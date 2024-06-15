# frozen_string_literal: true

module BillingAccount::Add
  class << self
    def call(billing_account_response)
      billing_account = BillingAccount.create(
        external_uid: billing_account_response[:uid],
        utility_account_id: billing_account_response[:base][:billing_account],
        contact_name: billing_account_response[:base][:billing_contact],
        user_id: set_user.id,
        authorization_id: set_authorization(billing_account_response[:authorization_uid]).id
      )
      
      billing_account
    end

    private

    def set_authorization(authorization_uid)
      @authorization ||= Authorization.find_by(external_uid: authorization_uid)
    end

    def set_user(authorization_uid)
      set_authorization(authorization_uid)&.user
    end
  end
end