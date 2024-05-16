# frozen_string_literal: true

module UtilityApi
  module Meters
    class GetOne < ApplicationService
      def initialize(meter_id, connection)
        @meter_id = meter_id
        @connection = connection
      end

      def call
        @connection.get_meter(@meter_id)
      end
    end
  end
end