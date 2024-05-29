# frozen_string_literal: true

module UtilityApi
  module Bills
    class GetList < ApplicationService
      def initialize(params, connection)
        @params = params
        @connection = connection
      end

      def call
        @connection.list_bills(@params)
      end
    end
  end
end