require 'rails_helper'

RSpec.describe "Meters", type: :request do
  describe "GET /index" do
    skip "returns http success" do
      get "/meters/index"
      expect(response).to have_http_status(:success)
    end
  end
end
