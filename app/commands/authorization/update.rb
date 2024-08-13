# frozen_string_literal: true

module Authorization::Update
  class << self
    def call(authorization)
      raw_auths = fetch_raw_auths({uids: authorization.external_uid})
      return if raw_auths.empty?

      raw_auths.each do |raw_auth|
        if Time.zone.parse(raw_auth[:status_ts]) > authorization.status_updated_at
          authorization.update(
            submitted_at: raw_auth[:created],
            customer_email: raw_auth[:customer_email],
            customer_signature: raw_auth[:customer_signature],
            declined_at: raw_auth[:declined],
            expired_at: raw_auth[:expires],
            exports_list: raw_auth[:exports_list],
            is_archived: raw_auth[:is_archived],
            notes: raw_auth[:notes],
            nickname: raw_auth[:nickname],
            revoked_at: raw_auth[:revoked],
            scope: raw_auth[:scope],
            status_message: raw_auth[:status_message],
            status_updated_at: raw_auth[:status_ts],
            utility: raw_auth[:utility],
          )
        end
      end
    end

    private

    def fetch_raw_auths(params)
      raw_auths = connection.list_authorizations(params)
      raw_auths[:body][:authorizations]
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end