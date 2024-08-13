# frozen_string_literal: true

module Webhook::ProcessMeter
  class << self
    def call(event)
      meter_uid = event[:meter_uid]
      if Meter.exists?(external_uid: meter_uid)
        Meter::Update.call(Meter.find_by(external_uid: meter_uid))
      else
        Meter::FetchOne.call({uids: meter_uid})
      end

      meter_event_type(event)
    end

    def meter_event_type(event)
      case event[:type]
      when "meter_created"
        Meter::StartHistoricalCollection.call({meters: event[:meter_uid]})
      when "meter_bills_added"
        Bill::FetchOne.call({meters: event[:meter_uid]})
      when "meter_intervals_added"
        Reading::FetchOne.call({meters: event[:meter_uid]})
      end
    end
  end
end


# when "meter_historical_collection_started"
# when "meter_historical_collection_delayed"
# when "meter_historical_collection_retrying"
# when "meter_historical_collection_progress"
# when "meter_historical_collection_finished_successful"
# when "meter_historical_collection_finished_errored"
