require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
      # expect(response).to render_template(:index)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/about"
      expect(response).to have_http_status(:success)
      # expect(response).to render_template(:about)
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get "/contact"
      expect(response).to have_http_status(:success)
      # expect(response).to render_template(:contact)
    end
  end

  describe "GET /products" do
    it "returns http success" do
      get "/products"
      expect(response).to have_http_status(:success)
      # expect(response).to render_template(:products)
    end
  end

  describe "GET /features" do
    it "returns http success" do
      get "/features"
      expect(response).to have_http_status(:success)
      # expect(response).to render_template(:features)
    end
  end
end