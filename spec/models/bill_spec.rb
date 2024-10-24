require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe "associations" do
    it "should belong to meter" do
      bill = create(:bill)
      expect(bill).to belong_to(:meter)
    end

    it "should have many line items" do
      bill = create(:bill)
      expect(bill).to have_many(:line_items)
    end
  end
end

# == Schema Information
#
# Table name: bills
#
#  id               :uuid             not null, primary key
#  external_uid     :string           not null
#  start_at         :datetime         not null
#  end_at           :datetime         not null
#  total_unit       :string
#  total_cost_cents :integer
#  raw_url          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  statement_at     :datetime
#  meter_id         :uuid             not null
#  total_kwh        :decimal(10, 6)   default(0.0)
#  total_volume     :decimal(10, 6)   default(0.0)
#
