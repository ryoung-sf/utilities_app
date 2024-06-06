# frozen_string_literal: true

module Meter::FetchOne
  class << self
    def call(params, bill_id: nil, bill_response: nil)
      raw_meters = fetch_raw_meters(params)

      new_meters_from(raw_meters).each do |meter_response|
        meter = Meter::Add.call(meter_response)
        Bill::FetchOne.call({ meters: meter.external_uid }, meter_id: meter.id) unless bill_id
        BillingAccount::Add.call(meter.id, bill_id, bill_response) if bill_id
      end
    end

    private

    def fetch_raw_meters(params)
      raw_meters = connection.list_meters(params)
      raw_meters[:body][:meters]
    end

    def new_meters_from(raw_meters)
      Meter::FindNewMeters.call(raw_meters)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end