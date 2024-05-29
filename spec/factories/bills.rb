FactoryBot.define do
  factory :bill do
    external_uid { "MyString" }
    start_date { "2024-06-02 08:29:01" }
    end_date { "2024-06-02 08:29:01" }
    total_kwh_times_100 { 1 }
    total_unit { "MyString" }
    total_volume_times_100 { 1 }
    total_cost_cents { 1 }
    billing_account { nil }
    raw_url { "MyString" }
  end
end
