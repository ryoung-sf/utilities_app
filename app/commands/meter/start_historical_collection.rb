# frozen_string_literal: true

module Meter::StartHistoricalCollection
  class << self
    def call(meter, auth_uid)
      meter_uid_arr = [meter[:uid]]
      Meter::FetchOne.call({uids: meter[:uid]}, auth_uid) if start_collection(meter_uid_arr)
    end

    private

    def start_collection(meter_uid_arr)
      res = connection.start_historical_collection({meters: meter_uid_arr})
      res[:body][:success] ? true : false
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end