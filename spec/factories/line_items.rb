FactoryBot.define do
  factory :line_item do
    cost_cents { 52.88 }
    end_at { "2024-06-03 21:44:08" }
    start_at { "2024-06-03 21:44:08" }
    name { "Tier 1 Usage" }
    unit { "kwh" }
    bill { create(:bill) }
    rate { 0.1617 }
    volume { 327.0 }
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
