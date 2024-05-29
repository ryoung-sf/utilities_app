# frozen_string_literal: true

module Bill::FetchOne
  class << self
    def call(params, meter_id: nil, user_id:)
      raw_bills = fetch_raw_bills(params)

      new_bills_from(raw_bills).each do |bill_response|
        bill = Bill::Add.call(bill_response)
        binding.b
        # meter_id = if Meter.find_by(external_uid: bill_response[:meter_uid]).id -> add billingAccount
        # Meter:FetchOne.call(uid: bill_response[:meter_uid], bill: bill.id) unless meter_id
        # BillingAccount::Add.call(meter_id, bill.id, user_id) if meter_id
        #

        unless meter_id
          return meter_id = if Meter.find_by(external_uid: bill_response[:meter_uid]).id
          Meter:FetchOne.call({ uid: bill_response[:meter_uid] }, bill: bill.id, user_id:, bill_response: bill_response)
        end

        BillingAccount::Add.call(meter_id, bill.id, user_id, bill_response) if meter_id

      end
    end

    private

    def fetch_raw_bills(params)
      raw_bills = connection.list_bills(params)
      raw_bills[:body][:bills]
    end

    def new_bills_from(raw_bills)
      Meter::FindNewbills.call(raw_bills)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end