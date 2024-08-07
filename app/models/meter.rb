class Meter < ApplicationRecord
  belongs_to :authorization
  belongs_to :user
  
  has_many :bills, dependent: :destroy
  has_many :readings, dependent: :destroy
end

# == Schema Information
#
# Table name: meters
#
#  id                 :uuid             not null, primary key
#  external_uid       :string           not null
#  service_class      :string
#  service_id         :string           not null
#  service_tariff     :string
#  created_date       :datetime         not null
#  utility_meter_id   :string           not null
#  status_date        :datetime         not null
#  status             :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  billing_account_id :uuid             not null
#
