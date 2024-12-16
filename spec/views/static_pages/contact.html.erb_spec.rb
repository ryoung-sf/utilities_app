require "rails_helper"

RSpec.describe "static_pages/contact.html.erb", type: :view do
  it "renders the contact view" do
    render
    expect(rendered).to have_text("Contact Us")
  end
end