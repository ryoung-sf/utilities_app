# frozen_string_literal: true

require "rails_helper"

RSpec.describe Authorization::Add do
  
  def raw_auths
    json = File.read("spec/support/fixtures/authorizations/one_authorization.json")
    JSON.parse(json, symbolize_names: true)[:authorizations]
  end

  context "when new authorizations are saved" do
    it "creates new authorization" do
      auth = raw_auths.first
      expect { described_class.call(auth, default_user.id) }.to change { Authorization.count }.by(1)
    end
  end
end