# frozen_string_literal: true

module Interval::Add
  class << self
    def call(interval_response, meter_id)
      readings = interval_response[:readings]

      readings.each do |reading|
        reading[:datapoints].each do |datapoint|
          Interval.create(
            external_uid: interval_response[:uid],
            start_date: reading[:start],
            end_date: reading[:end],
            value_times_1000: multiply_value_by_1000(datapoint[:value]),
            unit: datapoint[:unit],
            volume_type: datapoint[:type],
            meter_id: meter_id,
          )
        end
      end
    end

    private

    def multiply_value_by_1000(value)
      value * 1000 unless value.nil?
    end
  end
end