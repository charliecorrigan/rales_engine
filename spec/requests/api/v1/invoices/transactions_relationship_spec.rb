require 'rails_helper'

describe 'Invoices Transactions API' do
  let(:invoice) { create(:invoice) }
  let!(:transactions) { create_list(:transaction, 3, invoice: invoice)}
  let!(:other_transaction) { create(:transaction) }
  context 'GET /api/v1/invoices/:id/transactions' do
    it 'returns a collection of transactions for that invoice' do
      get "/api/v1/invoices/#{invoice.id}/transactions"

      expect(response).to be_success

      raw_transactions = JSON.parse(response.body)
      raw_transaction = raw_transactions.first

      expect(raw_transactions.count).to be 3

      expect(raw_transaction).to have_key('id')
      expect(raw_transaction['id']).to be_a Integer

      expect(raw_transaction).to have_key('invoice_id')
      expect(raw_transaction['invoice_id']).to be_a Integer
      expect(raw_transaction['invoice_id']).to eq invoice.id

      expect(raw_transaction).to have_key('credit_card_number')
      expect(raw_transaction['credit_card_number']).to be_a String

      expect(raw_transaction).to have_key('result')
      expect(raw_transaction['result']).to be_a String
    end
  end
end