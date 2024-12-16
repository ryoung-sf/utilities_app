# frozen_string_literal: true

require "rails_helper"

RSpec.describe Bill::FetchOne do
  
  context "when no new bills are found" do
    it "does not create any new bills" do
      meter = create(:meter)
      create(:bill, meter:)
      params = { meters: meter.external_uid }
      utility_api_stub(method: :get, path: "bills", file: "spec/support/fixtures/bills/one_bill.json", query: hash_including(params))
      
      expect { described_class.call(params) }.not_to change(Bill, :count)
    end
  end
  
  context "when new bills are found" do
    it "does create a new bill" do
      meter = create(:meter)
      params = { meters: meter.external_uid }
      utility_api_stub(method: :get, path: "bills", file: "spec/support/fixtures/bills/one_bill.json", query: hash_including(params))
      
      expect { described_class.call(params) }.to change(Bill, :count).by(1)
    end
  end
end