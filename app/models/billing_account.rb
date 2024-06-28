class BillingAccount < ApplicationRecord
  belongs_to :user
  belongs_to :authorization

  has_many :meters, dependent: :destroy
  has_many :bills, through: :meters

  # validates :external_uid, presence: true
  # validates :utility_account_id, presence: true
end

# == Schema Information
#
# Table name: billing_accounts
#
#  id                 :uuid             not null, primary key
#  utility_account_id :string           not null
#  contact_name       :string
#  user_id            :uuid             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  external_uid       :string
#  authorization_id   :uuid             not null
#
