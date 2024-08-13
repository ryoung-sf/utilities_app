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

      # params: uids, authorizations, users, utility, is_activated, is_archived, is_monitored, after, expand_meter_blocks
      def list_meters(params)
        request(http_method: :get, endpoint: "meters", body: params)
      end

      # params: meters: [meter_uid]
      def start_historical_collection(params)
        params[:meters] = [params[:meters]]
        request(http_method: :post, endpoint: "meters/historical-collection", body: params)
      end

      # params: authorizations, meters, start, end, limit, order, after
      def list_bills(params)
        request(http_method: :get, endpoint: "bills", body: params )
      end

      # params: authorizations, meters, start, end, limit, order, after
      def list_intervals(params)
        request(http_method: :get, endpoint: "intervals", body: params)
      end

      # params: uids, forms, templates, users, referrals, is_archived, is_declinded, is_test, is_revoked is_expired, utility, after, include, expand_meter_blocks, limit
      def list_authorizations(params)
        request(http_method: :get, endpoint: "authorizations", body: params)
      end

      def list_billing_accounts(params)
        request(http_method: :get, endpoint: "accounting/billing-accounts", body: params)
      end
      
      # params: template_uid, authorization_uid customer_email, utility, scope
      def create_form(params)
        request(http_method: :post, endpoint: "forms", body: params)
      end
      
      # Webhooks
      # params: event_uid
      def get_event(event_uid)
        request(http_method: :get, endpoint: "events/#{event_uid}")
      end

      # params: is_delivered, after
      def list_events(params)
        request(http_method: :get, endpoint: "events", body: params)
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
            config.options.params_encoder = Faraday::FlatParamsEncoder
            config.request :authorization, 'Bearer', Rails.application.credentials.dig(:utility_api_token)
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