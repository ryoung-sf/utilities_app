# frozen_string_literal: true

module UtilityApi
  module Meters
    class Save < ApplicationService
      def initialize(meter_id)
        @meter_id = meter_id
      end

      def call
        # response = UtilityApi::Meters::Get.call(@meter_id, faraday_connection)
        UtilityApi::Meters::GetOne.call(@meter_id, faraday_connection)
        
      end

      private

      def faraday_connection
        @faraday_connection ||= UtilityApi::V2::Client.new
      end
    end
  end
end