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
    status { "pending" }
    body {  "{
      \"events\": [
          {
              \"delivery_method\": \"webhook\", 
              \"delivery_target\": \"https://yourserver.com/webhook-receiver\", 
              \"is_delivered\": false, 
              \"ts\": \"2018-03-03T01:05:28.119646+00:00\", 
              \"type\": \"authorization_created\", 
              \"uid\": \"0b346106\"
          }
      ], 
      \"next\": null
  }" }
  end
end
