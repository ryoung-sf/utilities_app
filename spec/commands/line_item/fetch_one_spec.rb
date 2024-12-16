# frozen_string_literal: true

require "rails_helper"

RSpec.describe LineItem::FetchOne do
  context "when a bill has new line items" do
    it "creates a new line items" do
      json = File.read("spec/support/fixtures/bills/one_bill.json")
      raw_line_items = JSON.parse(json, symbolize_names: true)[:bills].first[:line_items]
      bill = create(:bill)
      line_items = raw_line_items
      described_class.call(line_items, bill.id)

      expect(LineItem.count).to eq(5)
    end
  end
end