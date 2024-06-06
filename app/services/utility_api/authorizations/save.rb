# frozen_string_literals

module UtilityApi
  module Authorizations
    class Save < ApplicationService
      def initialize(params)
        @params = params
      end

      def call
        # response = UtilityApi::Authorizations::Create.call(@meter_id, faraday_connection)
        response = UtilityApi::Authorizations::GetList.call(@params, faraday_connection)
        
        # authorization = response[:body][:authorizations].first

        authorization = Authorization.new(
          auth_id: response[:body][:authorizations][0][:uid],
          submitted_date: response[:body][:authorizations][0][:created],
          customer_email: response[:body][:authorizations][0][:customer_email],
          customer_signature: response[:body][:authorizations][0][:customer_signature],
          declined_date: response[:body][:authorizations][0][:declined],
          expired_date: response[:body][:authorizations][0][:expires],
          exports_list: response[:body][:authorizations][0][:exports_list],
          is_archived: response[:body][:authorizations][0][:is_archived],
          notes: response[:body][:authorizations][0][:notes],
          nickname: response[:body][:authorizations][0][:nickname],
          revoked_date: response[:body][:authorizations][0][:revoked],
          scope: response[:body][:authorizations][0][:scope],
          status_message: response[:body][:authorizations][0][:status_message],
          status_updated_date: response[:body][:authorizations][0][:status_ts],
          utility: response[:body][:authorizations][0][:utility],
          user_id: User.first.id
        )

        authorization
        
      end

      private

      def faraday_connection
        @faraday_connection ||= UtilityApi::V2::Client.new
      end
    end
  end
end