# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reading::Add do
  def raw_readings
    json = File.read("spec/support/fixtures/readings/one_reading.json")
    JSON.parse(json, symbolize_names: true)[:readings].first
  end

  context "when new readings are found" do
    it "adds new readings" do
      meter = create(:meter)
      readings = raw_readings
      described_class.call(readings, meter.id)

      expect(Reading.count).to eq(2)
    end
  end
end