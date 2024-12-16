require "rails_helper"

RSpec.describe "static_pages/features.html.erb", type: :view do
  it "renders the features view" do
    render
    expect(rendered).to have_text("Features Coming Soon")
  end
end