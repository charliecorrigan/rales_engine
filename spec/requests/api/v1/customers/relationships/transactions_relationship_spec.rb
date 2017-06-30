require 'rails_helper'

describe 'Customers Transactions API' do
  let(:customer) { create(:customer) }
  let!(:invoice) {create(:invoice, :with_transactions, transaction_count: 3, customer: customer)}
  let!(:other_transaction) {create(:transaction)}

  context 'GET /api/v1/customers/:id/transactions' do
    it 'returns a collection of transactions for that customer' do
      get "/api/v1/customers/#{customer.id}/transactions"

      expect(response).to be_success

      raw_transactions = JSON.parse(response.body)
      raw_transaction = raw_transactions.first

      expect(raw_transactions.count).to be 3

      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")

      expect(raw_transaction['invoice_id']).to eq invoice.id
    end
  end
end
