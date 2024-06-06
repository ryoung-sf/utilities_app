class Bill < ApplicationRecord
  belongs_to :authorization
  
  has_one :billing_account
  has_many :meters, through: :billing_account
  has_many :line_items

  monetize :total_cost_cents
end

# == Schema Information
#
# Table name: bills
#
#  id                     :uuid             not null, primary key
#  external_uid           :string           not null
#  start_date             :datetime         not null
#  end_date               :datetime         not null
#  total_kwh_times_100    :integer
#  total_unit             :string
#  total_volume_times_100 :integer
#  total_cost_cents       :integer
#  raw_url                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  authorization_id       :uuid             not null
#
