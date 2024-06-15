# frozen_string_literal: true

require "rails_helper"

RSpec.describe "request_forms/new", type: :system do
  context "when user has no authorized billing accounts" do
    it "submits new account request Form" do
      login_as(default_user)
      # expect(page).to have_current_path("/request_forms/new")

      fill_in "customer_email", with: default_user.email
      fill_in "utility", with: "DEMO"
      click_on "Authorize!"
    end
  end
end