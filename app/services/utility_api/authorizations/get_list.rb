# frozen_string_literal: true

module UtilityApi
  module Authorizations
    class GetList < ApplicationService
      def initialize(params)
        @params = params
        @connection = faraday_connection
      end

      def call
        @connection.list_authorizations(@params)
      end

      private

      def faraday_connection
        @faraday_connection ||= UtilityApi::V2::Client.new
      end
    end
  end
end