# frozen_string_literal: true

require "rails_helper"

RSpec.describe Webhook::ProcessAuthorization do
  context "when authorization already exists" do
    it "updates the authorization" do
      json = File.read("spec/support/fixtures/webhooks/authorization_events.json")
      raw_event = JSON.parse(json, symbolize_names: true)

      authorization = create(:authorization, nickname: "Old Nickname", status_updated_at: Time.zone.local(2001, 2, 2))
      authorization_event = raw_event[:events].first

      expect(Authorization::Update).to receive(:call).with(authorization)
      described_class.call(authorization_event)
    end
  end
end