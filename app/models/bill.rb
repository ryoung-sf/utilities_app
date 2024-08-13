class Bill < ApplicationRecord
  belongs_to :meter
  has_many :line_items, dependent: :destroy

  monetize :total_cost_cents

  scope :ordered, -> { order(statement_at: :desc) }
  scope :statement_date_between, -> (start_date = nil, end_date = nil) {
    where(statement_at: start_date..end_date) if start_date.present? && end_date.present?
  }
  
  scope :statement_period_between, -> (start_date = nil, end_date = nil) {
    where(start_at: start_date.., end_at: ..end_date) if start_date.present? && end_date.present?
  }
end

# == Schema Information
#
# Table name: bills
#
#  id               :uuid             not null, primary key
#  external_uid     :string           not null
#  start_at         :datetime         not null
#  end_at           :datetime         not null
#  total_unit       :string
#  total_cost_cents :integer
#  raw_url          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  statement_at     :datetime
#  meter_id         :uuid             not null
#  total_kwh        :decimal(10, 6)   default(0.0)
#  total_volume     :decimal(10, 6)   default(0.0)
#
