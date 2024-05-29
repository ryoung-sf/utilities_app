class BillingAccount < ApplicationRecord
  belongs_to :user
  belongs_to :bill
  belongs_to :meter
end
