require 'rails_helper'

describe "Customer Favorite Merchant API" do
  context 'GET /api/v1/customers/:id/favorite_merchant'  do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      customer = create(:customer)

      merchants = create_list(:merchant, 2)

      invoices1 = create_list(:invoice, 2, :with_transactions, transaction_count: 1, customer: customer, merchant: merchants[0])
      create(:transaction, invoice: invoices1[0], result: 'failed')

      create_list(:invoice, 2, :with_transactions, transaction_count: 2, customer: customer, merchant: merchants[1])

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      expect(response).to be_success

      result = JSON.parse(response.body)

      expect(result["id"]).to eq(merchants[1].id)
    end
  end
end
