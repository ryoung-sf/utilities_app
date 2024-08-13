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
class InboundWebhook < ApplicationRecord
end
