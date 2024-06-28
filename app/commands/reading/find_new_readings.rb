# frozen_string_literal: true

module Reading::FindNewReadings
  class << self
    def call(raw_reading, meter_id)
      readings = []
      
      raw_reading.each do |reading|
        next if Reading.exists?(
          start_at: reading[:start],
          end_at: reading[:end],
          meter_id:
        )
        
        readings << reading
      end

      readings
    end
  end
end