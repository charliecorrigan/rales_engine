require 'rails_helper'

describe 'Customers Invoices API' do
  let(:customer) { create(:customer) }
  let!(:invoices) { create_list(:invoice, 3, customer: customer)}
  let!(:other_invoice) {create(:invoice)}

  context 'GET /api/v1/customers/:id/invoices' do
    it 'returns a collection of invoices for that customer' do
      get "/api/v1/customers/#{customer.id}/invoices"

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

      expect(raw_invoice['customer_id']).to eq customer.id
    end
  end
end
