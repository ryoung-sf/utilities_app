# frozen_string_literal: true

require "rails_helper"

RSpec.describe Bill::Add do

  def raw_bills
    json = File.read("spec/support/fixtures/bills/one_bill.json")
    JSON.parse(json, symbolize_names: true)[:bills]
  end
  
  context "when new bills are saved" do
    it "creates a new bill" do
      meter = create(:meter)
      bill = raw_bills.first
      described_class.call(bill, meter.id)

      expect(Bill.count).to eq(1)
    end
  end
end