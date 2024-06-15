require 'rails_helper'

RSpec.describe Interval, type: :model do
  describe "associations" do
    interval = create(:interval)

    expect(interval).to belong_to(:meter)
  end
end

# == Schema Information
#
# Table name: intervals
#
#  id               :uuid             not null, primary key
#  external_uid     :string           not null
#  start_date       :datetime         not null
#  end_date         :datetime         not null
#  unit             :string           not null
#  value_times_1000 :integer          default(0), not null
#  volume_type      :string           not null
#  meter_id         :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
