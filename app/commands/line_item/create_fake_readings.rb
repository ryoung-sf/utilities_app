# frozen_string_literal: true

module LineItem::CreateFakeReadings
  class << self
    def call(bill)
      meter = bill.meter
      return if Reading.exists?(start_at: bill.start_at.., end_at: ..bill.end_at, meter_id: meter)

      reading_start_at = bill.start_at

      readings_array = empty_readings_array(bill)
      random_kwh_readings(bill.total_kwh, readings_array).each do |reading|
        Reading.create(
          start_at: reading_start_at,
          end_at: reading_start_at + 3600,
          unit: "kwh",
          volume_type: "net",
          meter_id: meter.id,
          value: reading
        )
        reading_start_at = reading_start_at + 3600
      end
    end

    private

    def random_kwh_readings(total_kwh, readings_array)
      readings_array.count.times do |n|
        rand_kwh_value = rand()
        readings_array[n] += rand_kwh_value
        total_kwh -= rand_kwh_value
        if total_kwh <= 1
          split_total_kwh = total_kwh / 10
          1.upto(10) do |int|
            readings_array[-int] += split_total_kwh
          end
          total_kwh = 0
        end
        return readings_array if total_kwh == 0
  
      end
      random_kwh_readings(total_kwh, readings_array)
    end
  
    def empty_readings_array(bill, readings_per_day = 24)
      days = (bill.end_at - bill.start_at) / 86400
      num_of_readings = days * readings_per_day
      Array.new(num_of_readings, 0)
    end
  
    def retrieve_n_bills(meter, n = nil)
      meter.bills.order(statement_at: :desc).limit(n)
    end
  end
end