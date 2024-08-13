FactoryBot.define do
  factory :meter do
    external_uid { "45678" }
    service_class { "Comm-electric" }
    service_id { "1234222222-9" }
    service_tariff { "MyString" }
    created_date { Time.zone.now }
    utility_meter_id { "111.00222.333.002" }
    status_date { Time.zone.now }
    status { "updated" }
  end
end

# == Schema Information
#
# Table name: meters
#
#  id               :uuid             not null, primary key
#  external_uid     :string           not null
#  service_class    :string
#  service_id       :string           not null
#  service_tariff   :string
#  activated_at     :datetime         not null
#  utility_meter_id :string           not null
#  status_at        :datetime         not null
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :uuid             not null
#  authorization_id :uuid             not null
#  status_message   :string
#  notes            :jsonb
#
