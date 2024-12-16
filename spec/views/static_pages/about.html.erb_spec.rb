require "rails_helper"

RSpec.describe "static_pages/about.html.erb", type: :view do
  it "renders the about view" do
    render
    expect(rendered).to have_text("About Us")
  end
end