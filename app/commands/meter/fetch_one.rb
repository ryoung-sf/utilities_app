# frozen_string_literal: true

module Meter::FetchOne
  class << self
    def call(params)
      raw_meters = fetch_meters_response(params)
      
      return if raw_meters.blank?

      # user_id = Authorization.find(auth_id).user.id
      new_meters_from(raw_meters).each do |meter_response|
        auth = Authorization.find_by(external_uid: meter_response[:authorization_uid])
        Meter::Add.call(meter_response, auth.id, auth.user_id)
      end
    end

    private

    def fetch_meters_response(params, raw_meters: [])
      response = connection.list_meters(params)
      return raw_meters if response[:body][:meters].blank?

      raw_meters << response[:body][:meters]
      raw_meters.flatten!
      return raw_meters unless has_more_meters?(response)

      new_params = extract_additional_meters_query(response[:body])
      fetch_meters_response(new_params, raw_meters:)
    end

    def has_more_meters?(raw_body)
      raw_body[:next] ? true : false
    end

    def extract_additional_meters_query(raw_body)
      Rack::Utils.parse_query URI(raw_body[:next]).query
    end

    def new_meters_from(raw_meters)
      Meter::FindNewMeters.call(raw_meters)
    end

    def updated?(meter_response)
      meter_response[:status] == "updated"
    end

    def has_bills?(meter_response)
      meter_response[:bill_count] > 0
    end

    def has_intervals?(meter_response)
      meter_response[:interval_count] > 0
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end