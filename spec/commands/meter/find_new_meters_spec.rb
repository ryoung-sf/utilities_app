# frozen_string_literal: true

require "rails_helper"

RSpec.describe Meter::FindNewMeters do
  def raw_meters
    json = File.read("spec/support/fixtures/meters/one_meter.json")
    JSON.parse(json, symbolize_names: true)[:meters]
  end

  context "when the raw response contains no new meters" do
    it "finds zero new meters" do
      create(:meter)
      result = described_class.call(raw_meters)

      expect(result).to be_empty
    end
  end

  context "when the raw response contains new meters" do
    it "returns an array with new meters" do
      result = described_class.call(raw_meters)
      expect(result).to eq(raw_meters)
    end
  end
end