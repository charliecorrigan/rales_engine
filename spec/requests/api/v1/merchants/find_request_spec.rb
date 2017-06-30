require 'rails_helper'

describe 'Merchants Find API' do
  context "GET /api/v1/merchants/find?name=?" do
    it "sends first merchant with included name" do
      merchant1 = create(:merchant, name: "Bob Store")
      merchant2 = create(:merchant, name: "Rob Store")
      merchant3 = create(:merchant, name: "Bill Store")
      get "/api/v1/merchants/find?name=#{merchant1.name}"

      expect(response).to be_success
      merchant_result = JSON.parse(response.body)

      expect(merchant_result["id"]).to eq(merchant1.id)
    end
  end

  context "GET /api/v1/merchants/find?id=?" do
    it "sends first merchant with included id" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/find?id=#{merchants.first.id}"
      expect(response).to be_success

      merchant_result = JSON.parse(response.body)

      expect(merchant_result["id"]).to eq(merchants.first.id)
    end
  end

  context "GET /api/v1/merchants/find?created_at=?" do
    it "sends first merchant with included created_at" do
      merchant1 = create(:merchant, created_at: "2012-03-27T14:56:35.000Z")
      create(:merchant)
      create(:merchant)
      create(:merchant)

      get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"
      expect(response).to be_success

      merchant_result = JSON.parse(response.body)

      expect(merchant_result["id"]).to eq(merchant1.id)
    end
  end

  context "GET /api/v1/merchants/find?updated_at=?" do
    it "sends first merchant with included updated_at" do
      merchant1 = create(:merchant, updated_at: "2012-03-27T14:56:35.000Z")
      create(:merchant)
      create(:merchant)
      create(:merchant)

      get "/api/v1/merchants/find?updated_at=#{merchant1.updated_at}"
      expect(response).to be_success

      merchant_result = JSON.parse(response.body)

      expect(merchant_result["id"]).to eq(merchant1.id)
    end
  end
end
