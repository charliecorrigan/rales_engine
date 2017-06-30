require 'rails_helper'

describe 'Invoice_item Invoice API' do
  let(:invoice) { create(:invoice) }
  let!(:invoice_item) { create(:invoice_item, invoice: invoice)}
  context 'GET /api/v1/invoice_items/:id/invoice' do
    it 'returns the associated invoice' do
      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_success

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice).to have_key('id')
      expect(raw_invoice['id']).to be_a Integer
      expect(raw_invoice).to have_key('customer_id')
      expect(raw_invoice['customer_id']).to be_a Integer
      expect(raw_invoice).to have_key('merchant_id')
      expect(raw_invoice['merchant_id']).to be_a Integer
      expect(raw_invoice).to have_key('status')
      expect(raw_invoice['status']).to be_a String
    end
  end
end
