FactoryBot.define do
  factory :meter do
    uid { "MyString" }
    service_class { "MyString" }
    service_id { "MyString" }
    service_tariff { "MyString" }
    created { "MyString" }
    utility_meter_id { "MyString" }
    status_date { "MyString" }
    status { "MyString" }
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
#  created_date     :datetime         not null
#  utility_meter_id :string           not null
#  status_date      :datetime         not null
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  authorization_id :uuid             not null
#