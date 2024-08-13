class Webhooks::UtilityApiJob < ApplicationJob
  queue_as :default

  def perform(inbound_webhook)
    json = JSON.parse(inbound_webhook.body, symbolize_names: true)

    json[:events].each do |event|
      next if event[:type].include?("ping") || event[:type].include?("form")

      ::Webhook::ProcessAuthorization.call(event)
      ::Webhook::ProcessMeter.call(event) if event[:type].include?("meter")
    end
    inbound_webhook.update!(status: :processed)
  end
end
