require 'rails_helper'

RSpec.describe Authorization, type: :model do
  describe "associations" do
    it "should belong to user" do
      authorization = create(:authorization)
      expect(authorization).to belong_to(:user)
    end

    it "should respond to meters" do
      authorization = create(:authorization)
      expect(authorization).to have_many(:meters)
    end
  end

  describe "validations" do
    it "should validate presence of" do
      authorization = create(:authorization)
      expect(authorization).to validate_presence_of(:external_uid)
      expect(authorization).to validate_presence_of(:customer_email)
      expect(authorization).to validate_presence_of(:is_archived).allow_nil
      expect(authorization).to validate_presence_of(:utility)
    end
  end

  describe "is_declined?" do
    it "should return false when declined_date is nil" do
      authorization = create(:authorization)

      expect(authorization.is_declined?).to be false
    end

    it "should return true when declined_at is present" do
      authorization = create(:authorization)
      authorization.declined_at = 1.year.ago
      
      expect(authorization.is_declined?).to be true
    end
  end

  describe "is_expired?" do
    it "should return false when expired_at is nil" do
      authorization = create(:authorization)

      expect(authorization.is_expired?).to be false
    end

    it "should return false when expired_at is present and in the future" do
      authorization = create(:authorization)
      authorization.expired_at = 1.year.from_now
    
      expect(authorization.is_expired?).to be false
    end

    it "should return true when expired_at is present and in the past" do
      authorization = create(:authorization)
      authorization.expired_at = 1.year.ago
      
      expect(authorization.is_expired?).to be true
    end
  end

  describe "is_revoked?" do
    it "should return false when expired_at is nil" do
      authorization = create(:authorization)

      expect(authorization.is_revoked?).to be false
    end

    it "should return false when expired_at is present and in the future" do
      authorization = create(:authorization)
      authorization.revoked_at = Time.zone.now
    
      expect(authorization.is_revoked?).to be true
    end
  end
end

# == Schema Information
#
# Table name: authorizations
#
#  id                 :uuid             not null, primary key
#  external_uid       :string           not null
#  submitted_at       :datetime         not null
#  customer_email     :string           not null
#  customer_signature :jsonb
#  declined_at        :datetime
#  expired_at         :datetime
#  exports_list       :jsonb
#  is_archived        :boolean          default(FALSE), not null
#  notes              :jsonb
#  nickname           :string
#  revoked_at         :datetime
#  scope              :jsonb
#  status             :string
#  status_message     :string
#  status_updated_at  :datetime
#  utility            :string           not null
#  user_id            :uuid             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
