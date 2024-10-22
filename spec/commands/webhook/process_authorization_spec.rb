# frozen_string_literal: true

require "rails_helper"

RSpec.describe Webhook::ProcessAuthorization do
  context "when authorization already exists" do
    def raw_event
      json = File.read("spec/support/fixtures/webhooks/authorization_events.json")
      JSON.parse(json, symbolize_names: true)
    end

    def stub_authorization_update
      json = File.read("spec/support/fixtures/authorizations/one_authorization.json")
      stub_request(:get, "https://utilityapi.com/api/v2/authorizations")
        .with(query: hash_including({}))
        .to_return(status: 200, body: json, headers: { "Content-Type" => "application/json" })
    end

    it "updates the authorization" do
      authorization = create(:authorization, nickname: "Old Nickname", status_updated_at: Time.zone.local(2001, 2, 2))
      authorization_event = raw_event[:events].first

      # expect(Authorization::Update).to receive(:call).with(authorization)
      described_class.call(authorization_event)
    end
  end
end