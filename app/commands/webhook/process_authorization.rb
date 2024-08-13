# frozen_string_literal: true

module Webhook::ProcessAuthorization
  class << self
    def call(event)
      auth_uid = event[:authorization_uid]
      if Authorization.exists?(external_uid: auth_uid)
        Authorization::Update.call(Authorization.find_by(external_uid: auth_uid))
      else
        Authorization::FetchOne.call({uids: auth_uid, include: "meters"})
      end
    end

    private

    def authorization_types(event)
      case event[:type]
      when "authorization_update_finished_successful"
        Meter::FetchOne.call({authorizations: event[:authorization_uid]})
      end
      # "authorization_created"
      # "authorization_declined"
      # "authorization_renewed"
      # "authorization_update_started"
      # "authorization_update_delayed"
      # "authorization_update_retrying"
      # "authorization_update_progress"
      # "authorization_update_finished_revoked"

    end
  end
end