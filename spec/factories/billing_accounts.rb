FactoryBot.define do
  factory :billing_account do
    transient { auth { create(:authorization) } }
    utility_account_id { "194500235561" }
    contact_name { "General Services Corp" }
    external_uid { "20113" }
    user { auth.user }
    authorization { auth }
  end
end

# == Schema Information
#
# Table name: billing_accounts
#
#  id                 :uuid             not null, primary key
#  utility_account_id :string
#  contact_name       :string
#  user_id            :uuid             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  external_uid       :string
#  authorization_id   :uuid             not null
#
