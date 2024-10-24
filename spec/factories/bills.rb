FactoryBot.define do
  factory :bill do
    external_uid { "bill_12345" }
    start_at { "2024-06-02 08:29:01" }
    end_at { "2024-06-02 08:29:01" }
    total_unit { "kWh" }
    total_cost_cents { 21800 }
    raw_url { "https://utilityapi.com/api/v2/files/abc123abc123abc123" }
    statement_at { "2024-06-02 08:29:01" }
    meter { create(:meter) }
    total_kwh { 837.0 }
    total_volume { 837.0 }
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
