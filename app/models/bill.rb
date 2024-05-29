class Bill < ApplicationRecord
  has_one :billing_account
  has_many :meters, through: :bills

  monetize :total_cost_cents
end
