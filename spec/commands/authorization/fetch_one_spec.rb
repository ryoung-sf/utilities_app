# frozen_string_literal: true
require "rails_helper"

RSpec.describe Authorization::FetchOne do
  
  def stub_raw_auths
    json = File.read("spec/support/fixtures/authorizations/one_authorization.json")
    stub_request(:get, "https://utilityapi.com/api/v2/authorizations").to_return(status: 200, body: json, headers: { "Content-Type" => "application/json" })
  end

  context "when no new authorizations are found" do
    it "does not create any new authorizations" do
      create(:authorization)
      params = {}
      stub_raw_auths

      expect { described_class.call(params) }.not_to change(Authorization, :count)
    end
  end

  context "when new authorizations are found" do
    it "creates new authorizations" do
      create(:user, email: "pfry@planetexpress.com")
      params = {}
      stub_raw_auths

      expect { described_class.call(params) }.to change(Authorization, :count).by(1)
    end
  end
end