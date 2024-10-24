# frozen_string_literal: true

require "rails_helper"

RSpec.describe Authorization::FindNewAuths do
  def raw_auths
    json = File.read("spec/support/fixtures/authorizations/one_authorization.json")
    JSON.parse(json, symbolize_names: true)[:authorizations]
  end

  context "when the raw response contains no new authorizations" do
    it "finds zero new authorizations" do
      create(:authorization)
      result = described_class.call(raw_auths)

      expect(result).to be_empty
    end
  end

  context "when the raw response contains new authorizations" do
    it "returns new authorizations" do
      result = described_class.call(raw_auths)
      expect(result).to eq(raw_auths)
    end
  end
end