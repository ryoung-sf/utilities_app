# frozen_string_literal: true

module Authorization::FetchOne
  class << self
    def call(params, user_id)
      raw_auths = fetch_raw_auths(params)

      new_auths_from(raw_auths, user_id).each do |auth|
        new_auth = Authorization::Add.call(auth, user_id)
        meters = auth[:meters][:meters]
        if meters
          Meter::FindNewMeters.call(meters).each do |meter|
            Meter::Add.call(meter, new_auth.id, user_id)
          end
        end
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