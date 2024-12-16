require 'rails_helper'

RSpec.describe "static_pages/index.html.erb", type: :view do
  context "renders the home page" do
    it "has the correct navbar links" do
      render
  
      expect(rendered).to have_selector("div>h1", text: "Utility Bill Tracker")
      expect(rendered).to have_selector("div>a", text: "Products")
      expect(rendered).to have_selector("div>a", text: "Features")
      expect(rendered).to have_selector("div>a", text: "About")
      expect(rendered).to have_selector("div>a", text: "Contact")
      expect(rendered).to have_selector("div>a", text: "Log in")
    end

    it "has the correct main content" do
      render

      expect(rendered).to have_selector("div>h1", text: "Monitor your utility bill")
      expect(rendered).to have_selector("div>a", text: "Sign up")
    end

    it "has the app features" do
      render

      expect(rendered).to have_selector("div>p", text: "Connected Utility Accounts")
      expect(rendered).to have_selector("div>p", text: "Centralized Bill Management")
      expect(rendered).to have_selector("div>p", text: "Real-Time Meter Monitoring")
    end
  end
end
