# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Create bills" do
  context "when a user has no existing bills" do
    it "creates a new bills and readings and redirects to meters dashboard" do
      utility_api_stub(
        method: :get, 
        path: "authorizations",
        file: "./spec/support/fixtures/authorizations/one_authorization_meters.json", 
        query: { uids: "auth_12345" }
      )

      utility_api_stub(
        method: :get,
        path: "meters",
        file: "./spec/support/fixtures/meters/one_meter.json",
        query: { uids: "meter_12345" }
      )

      utility_api_stub(
        method: :get,
        path: "bills",
        file: "./spec/support/fixtures/bills/multiple_bills.json",
        query: { meters: "meter_12345" }
      )

      user = create(:user)
      user.confirm
      create(:authorization, user: user)
      create(:meter, user: user)
      
      visit root_path
      click_link "Log in"
      fill_in("email", with: user.email)
      fill_in("password", with: user.password)
      click_on("Log in")

      expect(page).to have_content("Your meter data is being collected. Please wait as your dashboard is prepared!")

      bills_added_webhook = File.read("./spec/support/fixtures/webhooks/meter_bills_added.json")
      post "/webhooks/utility_api", params: bills_added_webhook, headers: { "CONTENT_TYPE" => "application/json" }

      expect(user.bills.count).to equal(6)
      expect(user.readings).to_not be_empty

      expect(page).to have_content("Click here to view your dashboard!")

      click_link "Click here to view your dashboard!"
      expect(page).to have_content("Statement Details")
      expect(page).to have_content("Bill Details")
      expect(page).to have_content("Total KWH Usage")
      expect(page).to have_content("Past 6 Months")
      expect(page).to have_content("Peak Consumption Per Day")
    end
  end
end