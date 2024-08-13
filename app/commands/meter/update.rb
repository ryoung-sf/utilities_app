# frozen_string_literal: true

module Meter::Update
  class << self
    def call(meter)
      raw_meters = fetch_raw_meters({uids: meter.external_uid})
      return if raw_meters.empty?

      raw_meters.each do |raw_meter|
        if Time.zone.parse(raw_meter[:status_ts]) > meter.status_at
          meter.update(
            external_uid: raw_meter[:uid],
            service_class: raw_meter[:base][:service_class],
            service_id: raw_meter[:base][:service_identifier],
            service_tariff: raw_meter[:base][:service_tariff],
            activated_at: raw_meter[:created],
            utility_meter_id: raw_meter[:base][:meter_numbers][0],
            status_at: raw_meter[:status_ts],
            status: raw_meter[:status],
            status_message: raw_meter[:status_message],
            notes: raw_meter[:notes],
          )
        end
      end
    end

    private

    def fetch_raw_meters(params)
      raw_meters = connection.list_meters(params)
      raw_meters[:body][:meters]
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end