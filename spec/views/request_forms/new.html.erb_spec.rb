require "rails_helper"

RSpec.describe "request_forms/new.html.erb", type: :view do
  it "renders the about view" do
    render(locals: { current_user: default_user })

    expect(rendered).to have_text("Authorize Your Utility Account")
    expect(rendered).to have_text("Email address")
    expect(rendered).to have_text("Utility")
    expect(rendered).to have_button("Authorize")
  end
end