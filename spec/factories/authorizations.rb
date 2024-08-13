FactoryBot.define do
  factory :authorization do
    external_uid { "12345" }
    submitted_date { "2024-05-29 11:19:49" }
    customer_email { "user_utility_email@example.com" }
    customer_signature { '{"type"=>"text", "ts"=>"2016-01-01T12:30:24.653422+00:00", "full_name"=>"Philip J. Fry"}' }
    declined_date { nil }
    expired_date { nil }
    exports_list { '{}' }
    is_archived { false }
    notes { 
      '[{"type": "access_valid", "msg": "Succesfully registered with account number.", "ts": "2019-01-01T12:32:42.347321+00:00"}, {"type": "meters_full", "msg": "Found all meters available.", "ts"=>"2019-01-01T12:32:42.347321+00:00"},]'
    }
    nickname { "Home PGE Account" }
    revoked_date { nil }
    scope { "{}" }
    status { "Updated" }
    status_message { "Meters found!" }
    status_updated_date { "2019-01-01T12:32:42.347321+00:00" }
    utility { "PG&E" }
    user { default_user }
  end
end

# == Schema Information
#
# Table name: authorizations
#
#  id                 :uuid             not null, primary key
#  external_uid       :string           not null
#  submitted_at       :datetime         not null
#  customer_email     :string           not null
#  customer_signature :jsonb
#  declined_at        :datetime
#  expired_at         :datetime
#  exports_list       :jsonb
#  is_archived        :boolean          default(FALSE), not null
#  notes              :jsonb
#  nickname           :string
#  revoked_at         :datetime
#  scope              :jsonb
#  status             :string
#  status_message     :string
#  status_updated_at  :datetime
#  utility            :string           not null
#  user_id            :uuid             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
