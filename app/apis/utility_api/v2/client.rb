# frozen_string_literal: true

require "faraday"

module UtilityApi
  module V2
    class Client
      include HttpStatusCodes
      include ApiExceptions

      UTILITY_API_BASE_URL = "https://utilityapi.com/api/v2/"
      API_REQUSTS_QUOTA_REACHED_MESSAGE = "API rate limit exceeded"

      def get_meter(meter_id)
        request(http_method: :get, endpoint: "meters/#{meter_id}")
      end

      def list_meters(params)
        request(http_method: :get, endpoint: "meters", body: params)
      end

      def list_bills(params)
        request(http_method: :get, endpoint: "bills", body: params )
      end

      def list_intervals(params)
        request(http_method: :get, endpoint: "intervals", body: params)
      end

      def list_authorizations(params)
        request(http_method: :get, endpoint: "authorizations", body: params)
      end

      def list_billing_accounts(params)
        request(http_method: :get, endpoint: "accounting/billing-accounts", body: params)
      end

      def create_form(params)
        request(http_method: :post, endpoint: "forms", body: params)
      end

      private

      def client
        @client ||= begin
          options = {
            request: { 
              open_timeout: 1,
              read_timeout: 5,
              write_timeout: 5
            }
          }
          Faraday.new(
            url: UTILITY_API_BASE_URL,
            **options
          ) do |config|
            config.request :json
            # config.options.params_encoder = Faraday::FlatParamsEncoder
            config.request :authorization, :bearer, Rails.application.credentials.dig(:utility_api_token)
            config.response :json, parser_options: { symbolize_names: true }
            # config.response :raise_error
            config.response(:logger, Rails.logger, headers: true, bodies: true, log_level: :debug) do |logger|
              logger.filter(/(Authorization)([^&]+)/, '\1[REMOVED]')
            end
          end
        end
      end
      
      def request(http_method:, endpoint:, body: {})
        response = client.public_send(http_method, endpoint, body)
        response_status_body = {
          status: response.status,
          body: response.body
        }

        return response_status_body if response_successful?(response)

        raise error_class(response), "Code: #{response.status}, response: #{response.body}"
      end

      def error_class(response)
        case response.status
        when HTTP_BAD_REQUEST_CODE
          BadRequestError
        when HTTP_UNAUTHORIZED_CODE
          UnauthorizedError
        when HTTP_FORBIDDEN_CODE
          return ApiRequestsQuotaReachedError if api_requests_quota_reached?
          ForbiddenError
        when HTTP_NOT_FOUND_CODE
          NotFoundError
        when HTTP_UNPROCESSABLE_ENTITY_CODE
          UnprocessableEntityError
        end
      end

      def response_successful?(response)
        response.status == HTTP_OK_CODE
      end

      def api_requests_quota_reached?
        response.body.match?(API_REQUESTS_QUOTA_REACHED_MESSAGE)
      end
    end
  end
end