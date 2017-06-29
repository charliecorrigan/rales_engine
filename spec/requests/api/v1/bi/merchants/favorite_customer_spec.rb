require 'rails_helper'

describe "BI API - Merchant's Favorite Customer" do
  context 'GET /api/v1/merchants/:id/favorite_customer' do
    let (:merchant) { create(:merchant) }
    let (:customers) { create_list(:customer, 2) }

    let (:c0_invoice) { create(:invoice, merchant: merchant, customer: customers[0]) }
    let! (:c0i_transactions) { create_list(:transaction, 3, invoice: c0_invoice) }

    let (:c1_invoice) { create(:invoice, merchant: merchant, customer: customers[1]) }
    let! (:c1i_transactions) { create_list(:transaction, 2, invoice: c1_invoice) }
    let! (:c1i_transaction_failed) { create(:transaction, result: 'failed', invoice: c1_invoice) }

    it 'returns the customer who has conducted the most total number of successful transactions' do
      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customers[0].id)
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
    end
  end
end
