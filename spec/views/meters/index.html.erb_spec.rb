require 'rails_helper'

RSpec.describe "meters/index.html.erb", type: :view do
  context "When the page renders the dashboard" do
    it "should have a log out in the navbar" do
      meter = create(:meter)
      create(:bill, meter_id: meter.id)
      LineItem::CreateFakeReadings.call(meter.bills.first)

      render(locals: { bills: meter.bills, meter: meter, bill: meter.bills.first, current_user: default_user, readings: meter.readings })

      expect(rendered).to have_content("Logout")
      expect(rendered).to have_content("#{default_user.email}")
      expect(rendered).to have_content(" Jun  2, 2024 - Jul  1, 2024")
      expect(rendered).to have_content("#{meter.bills.first.total_kwh}")
    end
  end
end
