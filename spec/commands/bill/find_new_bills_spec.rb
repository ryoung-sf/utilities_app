# frozen_string_literal: true

require "rails_helper"

RSpec.describe Bill::FindNewBills do
  context "when the raw response contains no new bills" do
    it "finds zero new bills" do
      json = File.read("spec/support/fixtures/bills/one_bill.json")
      raw_bills = JSON.parse(json, symbolize_names: true)[:bills]
      
      create(:bill)
      result = described_class.call(raw_bills)

      expect(result).to be_empty
    end
  end

  context "when the raw response contains new bills" do
    it "returns new bills" do
      json = File.read("spec/support/fixtures/bills/one_bill.json")
      raw_bills = JSON.parse(json, symbolize_names: true)[:bills]
      
      result = described_class.call(raw_bills)
      expect(result).to eq(raw_bills)
    end
  end
end