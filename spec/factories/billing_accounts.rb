FactoryBot.define do
  factory :billing_account do
    utility_number { "MyString" }
    contact_name { "MyString" }
    user { nil }
    authorization { nil }
  end
end
