require 'rails_helper'

RSpec.describe Meter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
#  created_date     :datetime         not null
#  utility_meter_id :string           not null
#  status_date      :datetime         not null
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  authorization_id :uuid             not null
#