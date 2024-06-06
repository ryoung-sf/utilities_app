require 'rails_helper'

RSpec.describe BillingAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
#  meter_id           :uuid             not null
#  bill_id            :uuid             not null
#
