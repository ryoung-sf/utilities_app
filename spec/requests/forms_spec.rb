require 'rails_helper'

RSpec.describe "Forms", type: :request do
  describe "GET /new" do
    skip "returns http success" do
      get "/forms/new"
      pending expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    skip "returns http success" do
      get "/forms/create"
      pending expect(response).to have_http_status(:success)
    end
  end
end
