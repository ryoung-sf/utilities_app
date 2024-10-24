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

    def total_peak_kwh_chart_data
      [
        { name: "KWH Per Day", data: total_kwh_usage_per_day, yAxisID: "y" },
        { name: "Daily Peak KWH", data: peak_kwh_usage_per_day, yAxisID: "y1" }
      ]
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


[
  {
    "name":"KWH Per Day",
    "data":[
      ["2024-06-01","37.723052"],
      ["2024-06-02","30.978236"],
      ["2024-06-03","21.661634"],
      ["2024-06-04","24.826042"],
      ["2024-06-05","20.708642"],
      ["2024-06-06","27.999317"],
      ["2024-06-07","24.05819"],
      ["2024-06-08","26.982489"],
      ["2024-06-09","20.689287"],
      ["2024-06-10","22.261976"],
      ["2024-06-11","24.62125"],
      ["2024-06-12","25.649263"],
      ["2024-06-13","21.868432"],
      ["2024-06-14","23.151054"],
      ["2024-06-15","22.14241"],
      ["2024-06-16","23.688104"],
      ["2024-06-17","24.712271"],
      ["2024-06-18","23.110139"],
      ["2024-06-19","26.004498"],
      ["2024-06-20","23.209758"],
      ["2024-06-21","23.598668"],
      ["2024-06-22","26.582507"],
      ["2024-06-23","21.923431"],
      ["2024-06-24","24.178791"],
      ["2024-06-25","25.080148"],
      ["2024-06-26","25.781811"],
      ["2024-06-27","23.235212"],
      ["2024-06-28","25.796876"],
      ["2024-06-29","25.89525"],
      ["2024-06-30","24.881258"]
    ]
  },
  {
    "name":"Daily Peak KWH",
    "data":[
      ["2024-06-01","2.424646"],
      ["2024-06-02","2.602124"],
      ["2024-06-03","1.76314"],
      ["2024-06-04","1.878484"],
      ["2024-06-05","1.779875"],
      ["2024-06-06","1.745112"],
      ["2024-06-07","1.680031"],
      ["2024-06-08","1.719046"],
      ["2024-06-09","1.909777"],
      ["2024-06-10","1.71706"],
      ["2024-06-11","1.922979"],
      ["2024-06-12","1.920969"],
      ["2024-06-13","1.854614"],
      ["2024-06-14","1.582106"],
      ["2024-06-15","1.865215"],
      ["2024-06-16","1.855648"],
      ["2024-06-17","1.495843"],
      ["2024-06-18","1.572581"],
      ["2024-06-19","1.748926"],
      ["2024-06-20","1.720361"],
      ["2024-06-21","1.726759"],
      ["2024-06-22","1.872045"],
      ["2024-06-23","1.673091"],
      ["2024-06-24","1.861301"],
      ["2024-06-25","1.691098"],
      ["2024-06-26","1.979971"],
      ["2024-06-27","1.554716"],
      ["2024-06-28","1.923328"],
      ["2024-06-29","1.757306"],
      ["2024-06-30","1.858957"]
    ]
  }
]