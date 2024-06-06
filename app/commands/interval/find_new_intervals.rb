# frozen_string_literal: true

module Interval::FindNewIntervals
  class << self
    def call(raw_intervals, meter_id: nil)
      intervals = []

      raw_intervals.each do |interval|
        if meter_id.nil?
          meter_id = Meter.find_by(external_uid: interval[:meter_uid])&.id
          if meter_id.nil?
            Meter::FetchOne.call({uids: interval[:meter_uid]})
            meter_id = Meter.find_by(external_uid: interval[:meter_uid])&.id # bad code
          end
        end
        next if Interval.exists?(external_uid: interval[:uid], meter_id:)

      intervals << interval
      end

      intervals
    end
  end
end