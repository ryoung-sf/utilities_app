# frozen_string_literal: true

require "rails_helper"

RSpec.describe LineItem::Add do
  context "when new line items are saved" do
    it "creates a new line item" do
      json = File.read("spec/support/fixtures/bills/one_bill.json")
      raw_line_item = JSON.parse(json, symbolize_names: true)[:bills].first[:line_items]
      bill = create(:bill)
      line_item = raw_line_item.first
      described_class.call(line_item, bill.id)

      expect(LineItem.count).to eq(1)
    end
  end
end