# frozen_string_literal: true

require "rails_helper"

RSpec.describe Meter::Update do
  def stub_raw_meters(meter)
    json = File.read("spec/support/fixtures/meters/one_meter.json")
    stub_request(:get, "https://utilityapi.com/api/v2/meters")
      .with(query: hash_including({}))
      .to_return(status: 200, body: json, headers: { "Content-Type" => "application/json" })
  end

  context "when meter response has new information is updated" do
    it "updates the meter" do
      past_date = Time.zone.local(2011, 1, 1)
      meter = meter = create(:meter, status_at: past_date)
      stub_raw_meters(meter)
      described_class.call(meter)
      expect(meter.status_at).not_to eq(past_date)
    end
  end

  context "when meter response has no new information" do
    it "does not update the meter" do
      time = Time.zone.now
      meter = create(:meter, status_at: time)
      stub_raw_meters(meter)
      described_class.call(meter)
      expect(meter.status_at).to eq(time)
    end
  end
end