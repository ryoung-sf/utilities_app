# frozen_string_literal: true

require "rails_helper"

RSpec.describe Bill::FetchOne do
  def stub_raw_bills
    json = File.read("spec/support/fixtures/bills/one_bill.json")
    stub_request(:get, "https://utilityapi.com/api/v2/bills")
      .with(query: hash_including({}))
      .to_return(status: 200, body: json, headers: { "Content-Type" => "application/json" })
  end

  context "when no new bills are found" do
    it "does not create any new bills" do
      meter = create(:meter)
      create(:bill, meter:)
      params = { meters: meter.external_uid }
      stub_raw_bills

      expect { described_class.call(params) }.not_to change(Bill, :count)
    end
  end

  context "when new bills are found" do
    it "does create a new bill" do
      meter = create(:meter)
      params = { meters: meter.external_uid }
      stub_raw_bills

      expect { described_class.call(params) }.to change(Bill, :count).by(1)
    end
  end

end