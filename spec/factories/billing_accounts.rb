FactoryBot.define do
  factory :billing_account do
    utility_number { "MyString" }
    contact_name { "MyString" }
    user { nil }
    authorization { nil }
  end
end

# == Schema Information
#
# Table name: billing_accounts
#
#  id                 :uuid             not null, primary key
#  utility_account_id :string           not null
#  contact_name       :string
#  user_id            :uuid             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  meter_id           :uuid             not null
#  bill_id            :uuid             not null
#
