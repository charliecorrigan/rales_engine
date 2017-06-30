require 'rails_helper'

describe 'Transaction Invoice API' do
  let(:invoice) { create(:invoice, :with_transactions) }
  
  context 'GET /api/v1/transactions/:id/invoice' do
    it 'returns the associated invoice' do
      get "/api/v1/transactions/#{invoice.transactions.first.id}/invoice"

      expect(response).to be_success

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice).to have_key('customer_id')
      expect(raw_invoice['customer_id']).to be_a Integer
      expect(raw_invoice).to have_key('merchant_id')
      expect(raw_invoice['merchant_id']).to be_a Integer
      expect(raw_invoice).to have_key('status')
      expect(raw_invoice['status']).to be_a String

      expect(raw_invoice['id']).to eq invoice.id
    end
  end
end
