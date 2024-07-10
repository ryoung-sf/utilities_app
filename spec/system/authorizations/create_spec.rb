# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Create authorization" do
  
  context "when user has no authorized billing accounts" do
    def receive_params(**options)
      params = {
        include: "meters",
        referral: "1234",
        **options
      }
      params.to_query
    end
    
    it "submits new account request Form" do

      headers = {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{Rails.application.credentials[:utility_api_token]}",
        'Content-Type'=>'application/json',
        'User-Agent'=>'Faraday v2.9.0'
      }
      
      stub_request(:post, "https://utilityapi.com/api/v2/forms")
        .with(
          body: { customer_email: "user-100@example.com", utility: "DEMO", scope: { autocollect: true }, include: "meters" }.to_json,
          headers:
        )
        .to_return(
          status: 200,
          body: File.open("./spec/support/fixtures/forms/successful_request.json"),
          headers:
        )
      
      stub_request(:get, "https://utilityapi.com/api/v2/authorizations").
        with(
          query: { include: "meters", referrals: "1234" }.to_query,
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{Rails.application.credentials[:utility_api_token]}",
            'User-Agent'=>'Faraday v2.9.0'
          }
        ).
        to_return(
          status: 200,
          body: File.open("./spec/support/fixtures/authorizations/one_authorization_meters.json"),
          headers:
        )

      stub_request(:get, "https://utilityapi.com/api/v2/accounting/billing-accounts").
        with(
          query: { authorizations: "auth_12345"}.to_query,
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{Rails.application.credentials[:utility_api_token]}",
            'User-Agent'=>'Faraday v2.9.0'
          }
        ).
        to_return(
          status: 200,
          body: File.open("./spec/support/fixtures/billing_accounts/one_billing_account.json"),
          headers:
        )

      stub_request(:get, "https://utilityapi.com/api/v2/meters").
        with(
          query: { uid: "meter_12345"}.to_query,
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{Rails.application.credentials[:utility_api_token]}",
            'User-Agent'=>'Faraday v2.9.0'
          }
        ).
        to_return(
          status: 200,
          body: File.open("./spec/support/fixtures/meters/one_meter.json"),
          headers:
        )

      stub_request(:get, "https://utilityapi.com/api/v2/bills").
        with(
          query: { meters: "meter_12345"}.to_query,
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{Rails.application.credentials[:utility_api_token]}",
            'User-Agent'=>'Faraday v2.9.0'
          }
        ).
        to_return(
          status: 200,
          body: File.open("./spec/support/fixtures/bills/one_bill.json"),
          headers:
        )

      stub_request(:get, "https://utilityapi.com/api/v2/intervals").
        with(
          query: { meter_uid: "meter_12345"}.to_query,
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{Rails.application.credentials[:utility_api_token]}",
            'User-Agent'=>'Faraday v2.9.0'
          }
        ).
        to_return(
          status: 200,
          body: File.open("./spec/support/fixtures/readings/one_reading.json"),
          headers:
        )
      
      login_as(default_user)
      
      fill_in "customer_email", with: default_user.email
      fill_in "utility", with: "DEMO"
      click_on "Authorize!"

      visit "/authorizations/receive?#{receive_params}"
      
      expect(Authorization.count).to equal(1)
    end
  end
end
