# frozen_string_literals

module UtilityApi
  module Bills
    class Save < ApplicationService
      def initialize(params)
        @params = params
      end

      def call
        # response = UtilityApi::Meters::Get.call(@meter_id, faraday_connection)
        UtilityApi::Bills::GetList.call(@params, faraday_connection)
        
      end

      private

      def faraday_connection
        @faraday_connection ||= UtilityApi::V2::Client.new
      end
    end
  end
end