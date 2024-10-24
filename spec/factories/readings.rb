FactoryBot.define do
  factory :reading do
    start_at { "2015-01-07T08:30:00.000000-07:00" }
    end_at { "2015-02-05T08:45:00.000000-07:00" }
    unit { "kwh" }
    volume_type { "net" }
    meter { create(:meter) }
    value { 20.5 }
  end
end

# == Schema Information
#
# Table name: readings
#
#  id          :uuid             not null, primary key
#  start_at    :datetime         not null
#  end_at      :datetime         not null
#  unit        :string           not null
#  volume_type :string           not null
#  meter_id    :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  value       :decimal(10, 6)   default(0.0)
#
