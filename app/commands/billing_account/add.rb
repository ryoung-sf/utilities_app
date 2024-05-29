# frozen_string_literal: true

module BillingAccount::Add
  class << self
    def call(meter_id, bill_id, user_id, bill_response)
      return if exists?(meter_id, bill_id)
      
      billing_account = BillingAccount.create(
        utility_account_id: bill_response[:base][:billing_account],
        contact_name: bill_response[:base][:billing_contact],
        meter_id:,
        bill_id:,
        user_id: user_id,
      )
      
      billing_account
    end

    private

    def exists?(meter_id, bill_id)
      BillingAccount.exists?(meter_id:, bill_id:)
      @billing_account_id ||= BillingAccount.find_by(authorization_id: set_authorization(meter).id)&.id
    end
  end
end