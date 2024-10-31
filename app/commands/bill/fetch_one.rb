# frozen_string_literal: true

module Bill::FetchOne
  class << self
    def call(params)
      meter = Meter.find_by(external_uid: params[:meters])
      params = latest_bill(params, meter.id)
      raw_bills = fetch_raw_bills(params)
      return if raw_bills.blank?

      new_bills_from(raw_bills).each do |bill_response|
        new_bill = Bill::Add.call(bill_response, meter.id)
        LineItem::FetchOne.call(bill_response[:line_items], new_bill.id)
        LineItem::CreateFakeReadings.call(new_bill)
      end

      ActionCable.server.broadcast("bills", "Bills added!") if meter.reload.bills.any?
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

    def latest_bill(params, meter_id)
      bill = Bill.where(meter_id:,)&.order('end_at DESC')&.first if Bill.where(meter_id:).any?
      return params unless bill

      params[:start] = bill.end_at.strftime("%Y-%m-%d")
      params
    end
  end
end