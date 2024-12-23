class Bill < ApplicationRecord
  belongs_to :meter
  has_many :line_items, dependent: :destroy

  validates_presence_of :external_uid, :start_at, :end_at, :meter_id

  monetize :total_cost_cents

  scope :ordered, -> { order(statement_at: :desc) }
  scope :statement_date_between, -> (start_date = nil, end_date = nil) {
    where(statement_at: start_date..end_date) if start_date.present? && end_date.present?
  }
  
  scope :statement_period_between, -> (start_date = nil, end_date = nil) {
    where(start_at: start_date.., end_at: ..end_date) if start_date.present? && end_date.present?
  }

  scope :prior_6_months_statements, -> (end_date = nil) {
    where(statement_at: (5.month.ago(end_date))..(end_date)) if end_date.present?
  }

  scope :prior_year_statements, -> (end_date = nil) {
    where(statement_at: (12.month.ago(end_date))..(end_date)) if end_date.present?
  }

  class << self
    def bills_by_month_year
      group_by_month(:statement_at, format: "%b %y").sum(:total_cost_cents).transform_values { |v| v/100.0 }
    end

    def change_in_total_kwh
      bills_by_month_year.values.each_cons(2).map { |a, b| b - a }
    end
  end

  def change_in_total_cost
    prior_bill = Bill.where("statement_at < ?", statement_at).order(statement_at: :desc).first
    return 0 unless prior_bill
    
    (((total_cost - prior_bill.total_cost) / prior_bill.total_cost) * 100).round(2)
  end

  def change_in_total_kwh
    prior_bill = Bill.where("statement_at < ?", statement_at).order(statement_at: :desc).first
    return 0 unless prior_bill
    
    (((total_kwh - prior_bill.total_kwh) / prior_bill.total_kwh) * 100).round(2)
  end
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
