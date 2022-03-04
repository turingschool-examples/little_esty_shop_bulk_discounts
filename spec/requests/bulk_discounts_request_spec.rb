require 'rails_helper'

RSpec.describe "BulkDiscounts", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/bulk_discounts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/bulk_discounts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/bulk_discounts/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/bulk_discounts/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/bulk_discounts/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/bulk_discounts/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
