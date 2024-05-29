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
