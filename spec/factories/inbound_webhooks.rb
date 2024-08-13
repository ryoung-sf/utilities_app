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
FactoryBot.define do
  factory :inbound_webhook do
    status { "MyString" }
    body { "MyText" }
  end
end
