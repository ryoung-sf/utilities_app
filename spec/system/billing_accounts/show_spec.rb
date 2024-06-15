# frozen_string_literal: true

require "rails_helper"

RSpec.describe "billing_accounts/show", type: :system do
  it "redirects to new form if user has not billing accounts" do
    login_as(default_user)

    expect(default_user.billing_accounts).to be_empty
    expect(page).to have_current_path("/forms/new")
    expect(page).to have_content("It looks like you don't have any accounts. Let's add one!")
  end
end