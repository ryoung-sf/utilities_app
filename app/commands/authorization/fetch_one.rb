# frozen_string_literal: true

module Authorization::FetchOne
  class << self
    def call(params)
      raw_auths = fetch_raw_auths(params)
      new_auths_from(raw_auths).each do |auth|
        user_id = User.find_by(email: auth[:customer_email]).id
        Authorization::Add.call(auth, user_id)
      end
    end

    private

    def fetch_raw_auths(params)
      raw_auths = connection.list_authorizations(params)
      raw_auths[:body][:authorizations]
    end

    def new_auths_from(raw_auths)
      Authorization::FindNewAuths.call(raw_auths)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end