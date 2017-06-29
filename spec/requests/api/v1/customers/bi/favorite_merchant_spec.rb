require 'rails_helper'

describe "Customer Favorite Merchant API" do
  context 'GET /api/v1/customers/:id/favorite_merchant'  do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      customer = create(:customer)

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      invoice1 = create(:invoice, customer: customer, merchant: merchant1)
      invoice2 = create(:invoice, customer: customer, merchant: merchant2)
      invoice3 = create(:invoice, customer: customer, merchant: merchant2)
      invoice4 = create(:invoice, customer: customer, merchant: merchant1)

      create(:transaction, invoice: invoice1)
      create(:transaction, invoice: invoice2)
      create(:transaction, invoice: invoice3)
      create(:transaction, invoice: invoice4, result: 'failed')

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      expect(response).to be_success

      result = JSON.parse(response.body)

      expect(result["id"]).to eq(merchant2.id)
    end
  end
end