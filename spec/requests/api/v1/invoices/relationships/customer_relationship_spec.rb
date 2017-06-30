require 'rails_helper'

describe 'Invoice Customer API' do
  let(:customer) { create(:customer) }
  let!(:invoice) { create(:invoice, customer: customer)}
  context 'GET /api/v1/invoices/:id/customer' do
    it 'returns the associated customer' do
      get "/api/v1/invoices/#{invoice.id}/customer"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(raw_customer).to have_key('id')
      expect(raw_customer['id']).to be_a Integer
      expect(raw_customer).to have_key('first_name')
      expect(raw_customer['first_name']).to be_a String
      expect(raw_customer).to have_key('last_name')
      expect(raw_customer['last_name']).to be_a String

      expect(raw_customer['id']).to eq customer.id
    end
  end
end
