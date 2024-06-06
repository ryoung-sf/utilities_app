# frozen_string_literal: true

module Authorization::FindNewAuths
  class << self
    def call(raw_auths, user_id)
      auths = []

      raw_auths.each do |auth|
        next if Authorization.exists?(external_uid: auth[:uid], user_id:)

        auths << auth
      end

      auths
    end
  end
end