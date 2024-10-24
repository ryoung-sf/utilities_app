# frozen_string_literal: true

class Webhooks::UtilityApiController < Webhooks::BaseController
  def create
    record = InboundWebhook.create(body: payload)

    # Queue database record for processing
    Webhooks::UtilityApiJob.perform_later(record)

    head 200
  end

  private

  def payload
    @payload ||= request.body.read
  end

  def verify_event
    secret = Rails.application.credentials.dig(:utility_api_webhook_secret)
    signature = request.headers['X-UtilityAPI-Webhook-Signature']
    salt = request.headers['X-UtilityAPI-Webhook-Salt']
    combined_string = "#{secret}.#{salt}.#{payload}"
    digest = Digest::SHA256.hexdigest(combined_string)
    if digest != signature
      return head :bad_request
    end
    true
  end
end
