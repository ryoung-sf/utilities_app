# frozen_string_literal: true

require "rails_helper"

RSpec.describe Bill::Add do
  context "when new bills are saved" do
    it "creates a new bill" do
      json = File.read("spec/support/fixtures/bills/one_bill.json")
      raw_bills = JSON.parse(json, symbolize_names: true)[:bills]
      
      meter = create(:meter)
      bill = raw_bills.first
      described_class.call(bill, meter.id)

      expect(Bill.count).to eq(1)
    end
  end
end