# frozen_string_literal: true

module BillingAccount::FindNewBillingAccounts
  class << self
    def call(raw_billing_accounts)
      billing_accounts = []

      raw_billing_accounts.each do |billing_account|
        next if BillingAccount.exists?(external_uid: billing_account[:uid])

        billing_accounts << billing_account
      end

      billing_accounts
    end
  end
end