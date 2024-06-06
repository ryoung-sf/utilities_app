require 'rails_helper'

RSpec.describe Authorization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
