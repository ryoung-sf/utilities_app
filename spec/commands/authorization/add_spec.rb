# frozen_string_literal: true

require "rails_helper"

RSpec.describe Authorization::Add do
  context "when new authorizations are saved" do
    it "creates new authorization" do
      json = File.read("spec/support/fixtures/authorizations/one_authorization.json")
      raw_auths = JSON.parse(json, symbolize_names: true)[:authorizations].first
      auth = raw_auths
      expect { described_class.call(auth, default_user.id) }.to change { Authorization.count }.by(1)
    end
  end
end