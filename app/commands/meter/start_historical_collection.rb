# frozen_string_literal: true

module Meter::StartHistoricalCollection
  class << self
    def call(params)
      start_collection(params)
    end

    private

    def start_collection(params)
      res = connection.start_historical_collection(params)
      res[:body][:success] ? true : false
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end