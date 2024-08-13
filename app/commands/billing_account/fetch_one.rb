# frozen_string_literal: true

module BillingAccount::FetchOne
  class << self
    def call(params, user_id)
      raw_billing_accounts = fetch_raw_billing_accounts(params)

      if raw_billing_accounts.blank?
        new_billing_account = BillingAccount::Add.call(temp_billing_account_response(params), user_id)
        Meter::FetchOne.call({authorizations: params[:authorizations]})
      else
        new_billing_accounts_from(raw_billing_accounts).each do |billing_account_response|
          # SendApiRequestJob.set(good_job_labels: ["utility_request"])
          #   .perform_later(Meter::FetchOne.call({uid: billing_account_response[:meter_uids][0]}))
          new_billing_account = BillingAccount::Add.call(billing_account_response, user_id)
          Meter::FetchOne.call({uid: billing_account_response[:meter_uids][0]})
        end
      end
    end

    private

    def fetch_raw_billing_accounts(params)
      raw_billing_accounts = connection.list_billing_accounts(params)
      return raw_billing_accounts[:body][:billing_accounts] if raw_billing_accounts[:body][:next] == "null"
      # if raw_bills[:body][:next] != null # https://utilityapi.com/api/v2/accounting/billing-accounts?after=234

      # end
    end

    def new_billing_accounts_from(raw_billing_accounts)
      BillingAccount::FindNewBillingAccounts.call(raw_billing_accounts)
    end

    def connection
      connection ||= UtilityApi::V2::Client.new
    end

    def temp_billing_account_response(params) 
      billing_account_response = {
        authorization_uid: params[:authorizations],
        external_uid: nil,
        base: {
          billing_account: nil,
          billing_contact: nil,
        }
      }

      billing_account_response
    end

    # def parse_next_url(url) 
    #   url.split("?")[1].split("=")
    # end
  end
end