# frozen_string_literal: true

require "rails_helper"

RSpec.describe Meter::FetchOne do
  def stub_raw_meters
    json = File.read("spec/support/fixtures/meters/one_meter.json")
    stub_request(:get, "https://utilityapi.com/api/v2/meters")
      .with(query: hash_including({}))
      .to_return(status: 200, body: json, headers: { "Content-Type" => "application/json" })
  end

  context "when the meter is not found" do
    it "does not create a new meter" do
      create(:meter)
      params = {}
      stub_raw_meters

      expect { described_class.call(params) }.not_to change(Meter, :count)
    end
  end

  context "when the meter is found" do
    it "creates a new meter" do
      create(:authorization)
      params = {}
      stub_raw_meters

      expect { described_class.call(params) }.to change(Meter, :count).by(1)
    end
  end
end