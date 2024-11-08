# frozen_string_literal: true

require "rails_helper"

RSpec.describe "request_forms/new", type: :system do
  context "when user has no authorized accounts" do
    it "submits new account request Form" do
      utility_api_stub(
        method: :post,
        path: "forms",
        file: "./spec/support/fixtures/forms/successful_request.json",
      )

      utility_api_stub(
        method: :get,
        path: "authorizations",
        file: "./spec/support/fixtures/authorizations/one_authorization_meters.json",
        query: { referrals: "1234" }
      )

      login_as(default_user)

      expect(page).to have_content("Authorize Your Utility Account")

      fill_in "customer_email", with: default_user.email
      fill_in "utility", with: "DEMO"
      click_on "Authorize!"

      visit "/authorizations/receive?#{receive_params}"

      expect(page).to have_content("Your meter data is being collected. Please wait as your dashboard is prepared!")
    end
  end
end