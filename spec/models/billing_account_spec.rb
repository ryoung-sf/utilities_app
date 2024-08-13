require 'rails_helper'

RSpec.describe BillingAccount, type: :model do
  describe "associations" do
    it "should belong to" do
      billing_account = create(:billing_account)

      expect(billing_account).to belong_to(:user)
      expect(billing_account).to belong_to(:authorization)
    end

    it "should have many" do
      billing_account = create(:billing_account)

      expect(billing_account).to have_many(:meters).dependent(:destroy)
      expect(billing_account).to have_many(:bills).dependent(:destroy)
    end
  end

  describe "validations" do
    it "should validate presence of" do
      billing_account = create(:billing_account)

      expect(billing_account).to validate_presence_of(:external_uid)
      expect(billing_account).to validate_presence_of(:utility_account_id)
    end
  end
end

# == Schema Information
#
# Table name: billing_accounts
#
#  id                 :uuid             not null, primary key
#  utility_account_id :string
#  contact_name       :string
#  user_id            :uuid             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  external_uid       :string
#  authorization_id   :uuid             not null
#
