# frozen_string_literal: true
require "rails_helper"

RSpec.describe Authorization::FetchOne do
  context "when no new authorizations are found" do
    it "does not create any new authorizations" do
      create(:authorization)
      params = {}
      utility_api_stub(method: :get, path: "authorizations", file: "spec/support/fixtures/authorizations/one_authorization.json", query: hash_including(params))
      
      expect { described_class.call(params) }.not_to change(Authorization, :count)
    end
  end
  
  context "when new authorizations are found" do
    it "creates new authorizations" do
      create(:user, email: "pfry@planetexpress.com")
      params = {}
      utility_api_stub(method: :get, path: "authorizations", file: "spec/support/fixtures/authorizations/one_authorization.json", query: hash_including(params))

      expect { described_class.call(params) }.to change(Authorization, :count).by(1)
    end
  end
end