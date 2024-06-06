require 'rails_helper'

RSpec.describe LineItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: line_items
#
#  id               :uuid             not null, primary key
#  cost_cents       :integer          not null
#  end_date         :datetime         not null
#  start_date       :datetime         not null
#  name             :string           not null
#  rate_times_10000 :integer
#  unit             :string
#  volume_times_100 :integer
#  bill_id          :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
