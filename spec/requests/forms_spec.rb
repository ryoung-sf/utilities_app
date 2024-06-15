require 'rails_helper'

RSpec.describe "Forms", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/forms/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/forms/create"
      expect(response).to have_http_status(:success)
    end
  end

end
