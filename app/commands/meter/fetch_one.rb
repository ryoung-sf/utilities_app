# frozen_string_literal: true

module Meter::FetchOne
  class << self
    def call(params, billing_account_id)
      raw_meters = fetch_raw_meters(params)
      return if raw_meters.blank?

      new_meters_from(raw_meters).each do |meter_response|
        # SendApiRequestJob.set(good_job_labels: ["utility_requests"])
        #   .perform_later(Bill::FetchOne.call({ meter_uids: meter_response[:uid]}))
        # SendApiRequestJob.set(good_job_labels: ["utility_requests"])
        #   .perform_later(Reading::FetchOne.call( meter_uids: meter_response[:uid]))
        
        meter = Meter::Add.call(meter_response, billing_account_id)
        Bill::FetchOne.call( {meters: meter_response[:uid]}, meter.id)
        Reading::FetchOne.call( {meters: meter_response[:uid]}, meter.id)
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