# frozen_string_literal: true

module Meter::FindNewMeters
  class << self
    def call(raw_meters)
      meters = []

      raw_meters.each do |meter|
        next if Meter.exists?(external_uid: meter[:uid])

        meters << meter
      end

      meters
    end
  end
end