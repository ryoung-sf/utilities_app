# frozen_string_literal: true

module Authorization::FetchOne
  class << self
    def call(params, user_id)
      raw_auths = fetch_raw_auths(params)

      new_auths_from(raw_auths, user_id).each do |auth|
        # SendApiRequestJob.set(good_job_labels: ["utility_request"])
        #   .perform_later(BillingAccount::FetchOne.call({authorization_uid: auth[:uid]}, user_id))
        Authorization::Add.call(auth, user_id)
        BillingAccount::FetchOne.call({authorizations: auth[:uid]}, user_id)
      end
    end

    private

    def fetch_raw_auths(params)
      raw_auths = connection.list_authorizations(params)
      raw_auths[:body][:authorizations]
    end

    def new_auths_from(raw_auths, user_id)
      Authorization::FindNewAuths.call(raw_auths, user_id)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end