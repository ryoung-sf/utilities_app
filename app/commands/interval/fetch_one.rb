# frozen_string_literal: true

module Interval::FetchOne
  class << self
    def call(params, meter_id: nil)
      raw_intervals = fetch_raw_intervals(params)

      new_intervals_from(raw_intervals, meter_id).each do |interval_response|
        Interval::Add.call(interval_response, meter_id)
      end
    end

    private

    def fetch_raw_intervals(params)
      raw_intervals = connection.list_intervals(params)
      raw_intervals[:body][:intervals]
    end

    def new_intervals_from(raw_intervals, meter_id)
      Interval::FindNewIntervals.call(raw_intervals, meter_id:)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end