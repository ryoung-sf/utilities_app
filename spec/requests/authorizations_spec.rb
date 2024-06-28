require 'rails_helper'

RSpec.describe "Authorizations", type: :request do
  describe "GET /receive" do
    it "returns http success" do
      get "/authorizations/receive"
      expect(response).to have_http_status(:success)
    end
  end

end
