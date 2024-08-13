require 'rails_helper'

RSpec.describe Reading, type: :model do
  describe "associations" do
    reading = create(:reading)

    expect(reading).to belong_to(:meter)
  end
end

# == Schema Information
#
# Table name: readings
#
#  id          :uuid             not null, primary key
#  start_at    :datetime         not null
#  end_at      :datetime         not null
#  unit        :string           not null
#  volume_type :string           not null
#  meter_id    :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  value       :decimal(10, 6)   default(0.0)
#
