require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe "associations" do
    it "should belong to a bill" do
      line_item = create(:line_item)
      expect(line_item).to belong_to(:bill)
    end
  end
end

# == Schema Information
#
# Table name: line_items
#
#  id         :uuid             not null, primary key
#  cost_cents :integer          not null
#  end_at     :datetime         not null
#  start_at   :datetime         not null
#  name       :string           not null
#  unit       :string
#  bill_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rate       :decimal(10, 6)   default(0.0)
#  volume     :decimal(10, 6)   default(0.0)
#
