class Authorization < ApplicationRecord
  belongs_to :user

  validates :auth_id, presence: true
  validates :customer_email, presence: true
  validates :is_archived, presence: true, allow_blank: true
  validates :utility, presence: true

  def is_declined?
    declined_date.present? ? true : false
  end

  def is_expired?
    if expired_date.present? && expired_date > Date.now
      true
    else
      false
    end
  end

  def is_revoked?
    revoked_date.present? ? true : false
  end
end
