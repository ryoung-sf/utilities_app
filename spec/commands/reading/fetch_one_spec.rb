# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reading::FetchOne do
  context "when new readings are found" do
    it "adds new readings" do
      meter = create(:meter)
      params = { meters: meter.external_uid }
      utility_api_stub(method: :get, path: "intervals", file: "spec/support/fixtures/readings/mulitple_readings.json", query: hash_including({}))
      
      expect { described_class.call(params) }.to change(Reading, :count).by(6)
    end
  end
  
  context "when no new readings are found" do
    it "does not create any new readings" do
      meter = create(:meter)
      create(:reading, meter: meter)
      params = { meters: meter.external_uid }
      utility_api_stub(method: :get, path: "intervals", file: "spec/support/fixtures/readings/one_reading.json", query: hash_including(params))
      
      expect { described_class.call(params) }.not_to change(Reading, :count)
    end
  end
end