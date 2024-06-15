# frozen_string_literal: true

module BillingAccount::FetchOne
  class << self
    def call(params)
      raw_bills = fetch_raw_bills(params)

      new_bills_from(raw_bills).each do |billing_account_response|
        BillingAccount::Add.call(billing_account_response)
      end
    end

    private

    def fetch_raw_billing_account(params)
      raw_billing_accounts = connection.list_billing_accounts(params)
      return raw_billing_accounts[:body][:billing_accounts] if raw_billing_accounts[:body][:next] == null
      # if raw_bills[:body][:next] != null # https://utilityapi.com/api/v2/accounting/billing-accounts?after=234

      # end
    end

    def new_bills_from(raw_billing_accounts)
      BillingAccounts::FindNewBillingAccounts.call(raw_billing_account)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end

    # def parse_next_url(url) 
    #   url.split("?")[1].split("=")
    # end
  end
end