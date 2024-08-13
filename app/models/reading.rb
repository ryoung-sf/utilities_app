class Reading < ApplicationRecord
  belongs_to :meter

  scope :ordered, -> { order(end_at: :desc) }
  
  scope :occurred_between, -> (start_date = nil, end_date = nil) {
    where(start_at: start_date.., end_at: ..end_date) if start_date.present? && end_date.present?
  }

  class << self
    def total_kwh_usage_per_day
      group_by_day(:start_at).sum(:value)
    end

    def peak_kwh_usage_per_day
      group_by_day(:start_at).maximum(:value)
    end

    def average_kwh_usage_per_day
      group_by_day(:start_at).average(:value)
    end

    def max_total_kwh_usage_per_day
      total_kwh_usage_per_day.values.max
    end

    def min_total_kwh_usage_per_day
      total_kwh_usage_per_day.values.min
    end

    def max_peak_kwh_usage_per_day
      peak_kwh_usage_per_day.values.max
    end

    def min_peak_kwh_usage_per_day
      peak_kwh_usage_per_day.values.min
    end
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
