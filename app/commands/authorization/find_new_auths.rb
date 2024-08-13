# frozen_string_literal: true

module Authorization::FindNewAuths
  class << self
    def call(raw_auths)
      auths = []

      raw_auths.each do |auth|
        next if Authorization.exists?(external_uid: auth[:uid])

        auths << auth
      end

      auths
    end
  end
end