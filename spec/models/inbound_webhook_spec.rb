# == Schema Information
#
# Table name: inbound_webhooks
#
#  id         :uuid             not null, primary key
#  status     :string           default("pending")
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe InboundWebhook, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
