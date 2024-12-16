# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Create meter" do
  context "when a user has no existing meters" do
    it "creates a new meter" do
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
        method: :post,
        path: "meters/historical-collection",
        file: "./spec/support/fixtures/meters/one_meter.json",
      )

      user = create(:user)
      user.confirm
      create(:authorization, user: user)
      
      visit root_path
      click_link "Log in"
      fill_in("email", with: user.email)
      fill_in("password", with: user.password)
      click_on("Log in")

      expect(page).to have_content("Your meter data is being collected. Please wait as your dashboard is prepared!")

      create_meter_webhook = File.read("./spec/support/fixtures/webhooks/meter_created.json")
      post "/webhooks/utility_api", params: create_meter_webhook, headers: { "CONTENT_TYPE" => "application/json" }

      perform_enqueued_jobs

      expect(user.meters.count).to equal(1)
    end
  end
end