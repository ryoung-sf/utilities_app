require "rails_helper"

RSpec.describe "static_pages/products.html.erb", type: :view do
  it "renders the products view" do
    render
    expect(rendered).to have_text("Products Coming Soon")
  end
end