# frozen_string_literal: true

module Authorization::FetchResponse
  class << self
    def call(params)
      fetch_raw_auths(params)
      SendApiRequestJob.set(good_job_labels: ["utility_request"])
        .perform_later(BillingAccount::FetchRawResponse.call(authorizations: ))
    end
    
    private
  
    def fetch_raw_auths(params)
      raw_auths = connection.list_authorizations(params)
      # if next is not null
      raw_auths[:body][:authorizations]
    end
  
  
    def connection
      connection ||= UtilityApi::V2::Client.new
    end
  end
end