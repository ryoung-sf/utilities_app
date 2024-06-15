FactoryBot.define do
  factory :bill do
    external_uid { "MyString" }
    start_date { "2024-06-02 08:29:01" }
    end_date { "2024-06-02 08:29:01" }
    total_kwh_times_100 { 1 }
    total_unit { "kWh" }
    total_volume_times_100 { 1 }
    total_cost_cents { 1 }
    billing_account { nil }
    raw_url { "MyString" }
  end
end

# == Schema Information
#
# Table name: bills
#
#  id                     :uuid             not null, primary key
#  external_uid           :string           not null
#  start_date             :datetime         not null
#  end_date               :datetime         not null
#  total_kwh_times_100    :integer
#  total_unit             :string
#  total_volume_times_100 :integer
#  total_cost_cents       :integer
#  raw_url                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  statement_date         :datetime
#  billing_account_id     :uuid             not null
#
