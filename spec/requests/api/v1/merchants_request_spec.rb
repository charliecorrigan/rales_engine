require 'rails_helper'

describe "Merchants API" do
  context 'GET /api/v1/merchants' do
    it "sends a list of merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_success

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(3)
    end
  end

  context 'GET /api/v1/merchants/:id' do
    xit 'sends one item by its id' do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      expect(response).to be_success

      merchant = JSON.parse(response.body)

      expect(merchant[:id]).to eq(id)
      expect(merchant).to have_key("name")
    end
  end
end

