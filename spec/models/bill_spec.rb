require 'rails_helper'

RSpec.describe Bill, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: bills
#
#  id                     :uuid             not null, primary key
#  external_uid           :string           not null
#  start_date             :datetime         not null
#  end_date               :datetime         not null
#  total_kwh_times_100    :integer
#  total_unit             :string
#  total_volume_times_100 :integer
#  total_cost_cents       :integer
#  raw_url                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  statement_date         :datetime
#  billing_account_id     :uuid             not null
#
