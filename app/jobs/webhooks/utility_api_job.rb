class Webhooks::UtilityApiJob < ApplicationJob
  queue_as :default

  def perform(inbound_webhook, user_id)
    json = JSON.parse(inbound_webhook.body, symbolize_name: true)

    json[:events].each do |event|
      case event[:type]
      when "authorization_created"
        unless Authorization.exists?(external_uid: event[:authorization_uid])
          Authorization.FetchOne.call({uid: event[:authorization]}, user_id)
        end
      # when "authorization_declined"
      #   # set status of auth to declined
      # when "authorization_renewed"
      #   # maybe changed to renewed, but just leave as is for now
      # when "authorization_update_started"
      # when "authorization_update_delayed"
      # when "authorization_update_retrying"
      # when "authorization_update_progress"
      # when "authorization_update_finished_successful"
      # when "authorization_update_finished_errored"
      # when "authorization_update_finished_expired"
      # when "authorization_update_finished_revoked"
      when "meter_created"
        return if Meter.exists?(external_uid: event[:meter_uid])

        auth = Authorization.find_by(external_uid: event[:authorization_uid])
        Meter::FetchOne.call({meters: event[:meter_uid]}, auth.id)
      when "meter_bills_added"
        auth = Authorization.find_by(external_uid: event[:authorization_uid])
        meter = Meter.find_by(external_uid: event[:meter_uid])
        Bill::FetchOne.call({meters: event[:meter_uid]}, meter.id)
      when "meter_intervals_added"
        auth = Authorization.find_by(external_uid: event[:authorization_uid])
        meter = Meter.find_by(external_uid: event[:meter_uid])
        Interval::FetchOne.call({meters: event[:meter_uid]}, meter.id)
      # when "meter_historical_collection_started"
      # when "meter_historical_collection_delayed"
      # when "meter_historical_collection_retrying"
      # when "meter_historical_collection_progress"
      # when "meter_historical_collection_finished_successful"
      # when "meter_historical_collection_finished_errored"

        
      else
        return event
        # inbound_webhook.update!(status: :skipped)
      end
    end
    # inbound_webhook.update!(status: :processed)
  end
end
