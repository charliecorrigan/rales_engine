require 'rails_helper'

describe 'Invoices API' do
  context 'GET /api/v1/invoices' do
    it 'sends a list of all invoices' do
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first

      expect(raw_invoices.count).to be 3
      expect(raw_invoice).to have_key('customer_id')
      expect(raw_invoice['customer_id']).to be_a Integer
      expect(raw_invoice).to have_key('merchant_id')
      expect(raw_invoice['merchant_id']).to be_a Integer
      expect(raw_invoice).to have_key('status')
      expect(raw_invoice['status']).to be_a String
    end
  end

  context 'GET /api/v1/invoices/:id' do
    it 'sends the information about one invoice' do
      invoice = create(:invoice)

      get "/api/v1/invoices/#{invoice.id}"

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice['id']).to eq invoice.id
      expect(raw_invoice).to have_key('customer_id')
      expect(raw_invoice['customer_id']).to be_a Integer
      expect(raw_invoice['customer_id']).to eq invoice.customer_id
      expect(raw_invoice).to have_key('merchant_id')
      expect(raw_invoice['merchant_id']).to be_a Integer
      expect(raw_invoice['merchant_id']).to eq invoice.merchant_id
      expect(raw_invoice).to have_key('status')
      expect(raw_invoice['status']).to be_a String
      expect(raw_invoice['status']).to eq invoice.status
    end
  end
end
