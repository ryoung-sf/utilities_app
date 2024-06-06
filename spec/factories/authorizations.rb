FactoryBot.define do
  factory :authorization do
    auth_id { "MyString" }
    submitted_date { "2024-05-29 11:19:49" }
    customer_email { "MyString" }
    customer_signature { "" }
    declined_on { "2024-05-29 11:19:49" }
    is_declined { false }
    expires_on { "2024-05-29 11:19:49" }
    is_expired { false }
    exports_list { "" }
    is_archived { false }
    is_test { false }
    notes { "" }
    nickname { "MyString" }
    revoked_on { "2024-05-29 11:19:49" }
    is_revoked { false }
    scope { "" }
    status { "MyString" }
    status_message { "MyString" }
    status_updated_on { "2024-05-29 11:19:49" }
    utility { "MyString" }
  end
end

# == Schema Information
#
# Table name: authorizations
#
#  id                  :uuid             not null, primary key
#  external_uid        :string           not null
#  submitted_date      :datetime         not null
#  customer_email      :string           not null
#  customer_signature  :jsonb
#  declined_date       :datetime
#  expired_date        :datetime
#  exports_list        :jsonb
#  is_archived         :boolean          default(FALSE), not null
#  notes               :jsonb
#  nickname            :string
#  revoked_date        :datetime
#  scope               :jsonb
#  status              :string
#  status_message      :string
#  status_updated_date :datetime
#  utility             :string           not null
#  user_id             :uuid             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
