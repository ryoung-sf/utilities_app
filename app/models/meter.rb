class Meter < ApplicationRecord
  belongs_to :authorization
  belongs_to :user
  
  has_many :bills, dependent: :destroy
  has_many :readings, dependent: :destroy

  delegate :occurred_between, to: :readings

  def bills_statement_date_between(start_date = nil, end_date = nil)
    bills.statement_date_between(start_date, end_date)
  end

  def bills_statement_period_between(start_date = nil, end_date = nil)
    bills.statement_period_between(start_date, end_date)
  end

  def total_kwh_per_day(ranged_readings)
    ranged_readings.group_by_day(:start_at).sum(:value)
  end

  def max_hourly_kwh_per_day(ranged_readings)
    ranged_readings.group_by_day(:start_at).maximum(:value)
  end

  def average_kwh_per_day(ranged_readings)
    ranged_readings.group_by_day(:start_at).average(:value)
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
