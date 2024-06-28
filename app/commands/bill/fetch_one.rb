# frozen_string_literal: true

module Bill::FetchOne
  class << self
    def call(params, meter_id)
      raw_bills = fetch_raw_bills(params)
      return if raw_bills.blank?

      new_bills_from(raw_bills).each do |bill_response|
        new_bill = Bill::Add.call(bill_response, meter_id)
        LineItem::FetchOne.call(bill_response[:line_items], new_bill.id)
      end
    end

    private

    def fetch_raw_bills(params)
      raw_bills = connection.list_bills(params)
      raw_bills[:body][:bills]
    end

    def new_bills_from(raw_bills)
      Bill::FindNewBills.call(raw_bills)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end