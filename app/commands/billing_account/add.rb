# frozen_string_literal: true

module BillingAccount::Add
  class << self
    def call(meter_id, bill_id, bill_response)
      return if exists?(meter_id, bill_id)
      
      billing_account = BillingAccount.create(
        utility_account_id: bill_response[:base][:billing_account],
        contact_name: bill_response[:base][:billing_contact],
        meter_id:,
        bill_id:,
        user_id: set_user_id(bill_response),
      )
      
      billing_account
    end

    private

    def exists?(meter_id, bill_id)
      BillingAccount.exists?(meter_id:, bill_id:)
    end

    def set_user_id(bill_response)
      Authorization.find_by(external_uid: bill_response[:authorization_uid]).user.id
    end
  end
end