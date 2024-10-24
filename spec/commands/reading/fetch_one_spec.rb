# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reading::FetchOne do
  file = File.read("spec/support/fixtures/readings/mulitple_readings.json")

  def stub_raw_readings(response: file)
    stub_request(:get, "https://utilityapi.com/api/v2/intervals")
      .with(query: hash_including({}))
      .to_return(status: 200, body: response, headers: { "Content-Type" => "application/json" })
  end

  context "when new readings are found" do
    it "adds new readings" do
      meter = create(:meter)
      params = { meters: meter.external_uid }
      stub_raw_readings(response: file)

      expect { described_class.call(params) }.to change(Reading, :count).by(6)
    end
  end

  context "when no new readings are found" do
    it "does not create any new readings" do
      meter = create(:meter)
      params = { meters: meter.external_uid }
      stub_raw_readings(response: "{}")

      expect { described_class.call(params) }.not_to change(Reading, :count)
    end
  end
end