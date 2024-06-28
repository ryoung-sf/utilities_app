class Authorization < ApplicationRecord
  belongs_to :user

  has_many :billing_accounts

  validates :external_uid, presence: true
  validates :customer_email, presence: true
  validates :is_archived, presence: true, allow_blank: true
  validates :utility, presence: true

  def is_declined?
    declined_at.present? ? true : false
  end

  def is_expired?
    if expired_at.present? && expired_at < Time.zone.now
      true
    else
      false
    end
  end

  def is_revoked?
    revoked_at.present? ? true : false
  end
end

# == Schema Information
#
# Table name: authorizations
#
#  id                  :uuid             not null, primary key
#  external_uid        :string           not null
#  submitted_date      :datetime         not null
#  customer_email      :string           not null
#  customer_signature  :jsonb
#  declined_date       :datetime
#  expired_date        :datetime
#  exports_list        :jsonb
#  is_archived         :boolean          default(FALSE), not null
#  notes               :jsonb
#  nickname            :string
#  revoked_date        :datetime
#  scope               :jsonb
#  status              :string
#  status_message      :string
#  status_updated_date :datetime
#  utility             :string           not null
#  user_id             :uuid             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
