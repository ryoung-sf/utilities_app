require 'rails_helper'

RSpec.describe Meter, type: :model do
  
  def create_meter(params: {})
    create(:meter, params)
  end

  describe "associations" do
    it "should belong to a user" do
      meter = create_meter
      expect(meter).to belong_to(:user)
    end

    it "should belong to an authorization" do
      meter = create_meter
      expect(meter).to belong_to(:authorization)
    end

    it "should have many readings" do
      meter = create_meter
      expect(meter).to have_many(:readings).dependent(:destroy)
    end

    it "should have many bills" do
      meter = create_meter
      expect(meter).to have_many(:bills)
    end
  end
end

# == Schema Information
#
# Table name: meters
#
#  id               :uuid             not null, primary key
#  external_uid     :string           not null
#  service_class    :string
#  service_id       :string           not null
#  service_tariff   :string
#  activated_at     :datetime         not null
#  utility_meter_id :string           not null
#  status_at        :datetime         not null
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :uuid             not null
#  authorization_id :uuid             not null
#  status_message   :string
#  notes            :jsonb
#
