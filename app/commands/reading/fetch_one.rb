# frozen_string_literal: true

module Reading::FetchOne
  class << self
    def call(params, meter_id)
      latest_interval(params, meter_id)
      raw_intervals = fetch_raw_readings(params)
      return if raw_intervals.blank?

      raw_intervals.each do |interval|
        readings = interval[:readings]
        new_readings_from(readings, meter_id).each do |reading|
          Reading::Add.call(reading, meter_id)
        end
      end
    end

    private

    def fetch_raw_readings(params)
      raw_readings = connection.list_intervals(params)
      raw_readings[:body][:intervals]
    end

    def new_readings_from(raw_readings, meter_id)
      Reading::FindNewReadings.call(raw_readings, meter_id)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end

    def latest_interval(params, meter_id)
      reading = Reading.find_by(meter_id:)&.order('end_at DESC')&.first
      return params unless reading

      params[:start] = reading.end_at
      params
    end
  end
end