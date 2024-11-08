# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Create authorization" do
  
  context "when user successfully submits an authorizatin request" do
    it "submits new account request Form" do
      utility_api_stub(
        method: :post,
        path: "forms",
        file: "./spec/support/fixtures/forms/successful_request.json"
      )

      utility_api_stub(
        method: :get,
        path: "authorizations",
        file: "./spec/support/fixtures/authorizations/one_authorization_meters.json",
        query: { referrals: "1234" }
      )

      login_as(default_user)
      
      fill_in "customer_email", with: default_user.email
      fill_in "utility", with: "DEMO"
      click_on "Authorize!"

      visit "/authorizations/receive?#{receive_params}"
      
      expect(Authorization.count).to equal(1)
      expect(page).to have_content("Your meter data is being collected. Please wait as your dashboard is prepared!")
    end
  end
end
