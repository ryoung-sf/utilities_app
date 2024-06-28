# frozen_string_literal: true

module Reading::Add
  class << self
    def call(reading, meter_id)
      reading[:datapoints].each do |datapoint|
        Reading.create(
          start_at: reading[:start],
          end_at: reading[:end],
          value: datapoint[:value],
          unit: datapoint[:unit],
          volume_type: datapoint[:type],
          meter_id: meter_id,
        )
      end
    end
  end
end