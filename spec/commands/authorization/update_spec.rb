# frozen_string_literal: true

require "rails_helper"

RSpec.describe Authorization::Update do
  context "when authorization is updated" do
    it "updates the authorization" do
      json = File.read("spec/support/fixtures/authorizations/one_authorization.json")
      stub_request(:get, "https://utilityapi.com/api/v2/authorizations?uids=auth_12345").to_return(status: 200, body: json, headers: { "Content-Type" => "application/json" })

      past_date = Time.zone.local(2011, 1, 1)
      authorization = create(:authorization, status_updated_at: past_date)

      described_class.call(authorization)
      expect(authorization.status_updated_at).not_to eq(past_date)
    end

    it "does not update the authorization" do
      json = File.read("spec/support/fixtures/authorizations/one_authorization.json")
      stub_request(:get, "https://utilityapi.com/api/v2/authorizations?uids=auth_12345").to_return(status: 200, body: json, headers: { "Content-Type" => "application/json" })
      
      time = Time.zone.now
      authorization = create(:authorization, status_updated_at: time)

      described_class.call(authorization)
      expect(authorization.status_updated_at).to eq(time)
    end
  end
end