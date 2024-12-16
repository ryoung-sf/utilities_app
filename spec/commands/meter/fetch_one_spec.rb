# frozen_string_literal: true

require "rails_helper"

RSpec.describe Meter::FetchOne do
  context "when the meter is not found" do
    it "does not create a new meter" do
      create(:meter)
      params = {}
      utility_api_stub(method: :get, path: "meters", file: "spec/support/fixtures/meters/one_meter.json", query: hash_including(params))

      expect { described_class.call(params) }.not_to change(Meter, :count)
    end
  end

  context "when the meter is found" do
    it "creates a new meter" do
      create(:authorization)
      params = {}
      utility_api_stub(method: :get, path: "meters", file: "spec/support/fixtures/meters/one_meter.json", query: hash_including(params))

      expect { described_class.call(params) }.to change(Meter, :count).by(1)
    end
  end
end