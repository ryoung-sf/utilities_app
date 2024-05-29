# frozen_string_literal: true

module Authorization::FetchOne
  class << self
    def call(user_id, params)
      raw_auths = fetch_raw_auths(params)

      new_auths_from(raw_auths, user_id).each do |auth|
        Authorization::Add.call(auth, user_id)
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