# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reading::FindNewReadings do
  context "when no new readings are found" do
    it "returns empty array" do
      json = File.read("spec/support/fixtures/readings/one_reading.json")
      raw_reading = JSON.parse(json, symbolize_names: true)[:readings]
      meter = create(:meter)
      create(:reading, meter: meter)
      result = described_class.call(raw_reading, meter.id)

      expect(result).to eq([])
    end
  end

  context "when new readings are found" do
    it "returns array of new readings" do
      json = File.read("spec/support/fixtures/readings/one_reading.json")
      raw_reading = JSON.parse(json, symbolize_names: true)[:readings]
      meter = create(:meter)
      result = described_class.call(raw_reading, meter.id)

      expect(result.count).to eq(1)
    end
  end
end