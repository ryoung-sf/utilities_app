# frozen_string_literal: true

module UtilityApi
  module Intervals
    class GetList < ApplicationService
      def initialize(params, connection)
        @params = params
        @connection = connection
      end

      def call
        @connection.list_intervals(@params)
      end
    end
  end
end