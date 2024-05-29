class Meter < ApplicationRecord
  has_one :billing_account

  has_many :bills, through: :billing_account
end
