# frozen_string_literal: true

module Bill::FetchOne
  class << self
    def call(params, meter_id: nil)
      raw_bills = fetch_raw_bills(params)

      new_bills_from(raw_bills).each do |bill_response|
        # api_meter_id = bill_response[:meter_id]
        # meter = Meter.find_by(external_uid: api_meter_id)
        # meter ||= Meter::FetchOne.call
        # if meter_id

        

        unless meter_id # clean this up
          meter_id = Meter.find_by(external_uid: bill_response[:meter_uid])&.id
          unless meter_id
            Meter::FetchOne.call({ uids: bill_response[:meter_uid] }, bill_id: bill.id, bill_response:)
          end
        end
        BillingAccount::Add.call(meter_id, bill.id, bill_response) if meter_id
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