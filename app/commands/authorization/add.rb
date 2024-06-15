# frozen_string_literal: true

module Authorization::Add
  class << self
    def call(auth, user_id)
      Authorization.create(
        external_uid: auth[:uid],
        submitted_date: auth[:created],
        customer_email: auth[:customer_email],
        customer_signature: auth[:customer_signature],
        declined_date: auth[:declined],
        expired_date: auth[:expires],
        exports_list: auth[:exports_list],
        is_archived: auth[:is_archived],
        notes: auth[:notes],
        nickname: auth[:nickname],
        revoked_date: auth[:revoked],
        scope: auth[:scope],
        status_message: auth[:status_message],
        status_updated_date: auth[:status_ts],
        utility: auth[:utility],
        user_id: User.first.id
      )
    end
  end
end