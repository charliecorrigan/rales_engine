require 'rails_helper'

describe 'Invoice Merchant API' do
  let(:merchant) { create(:merchant) }
  let!(:invoice) { create(:invoice, merchant: merchant)}
  context 'GET /api/v1/invoices/:id/merchant' do
    it 'returns the associated merchant' do
      get "/api/v1/invoices/#{invoice.id}/merchant"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant).to have_key('id')
      expect(raw_merchant['id']).to be_a Integer
      expect(raw_merchant).to have_key('name')
      expect(raw_merchant['name']).to be_a String

      expect(raw_merchant['id']).to eq merchant.id
    end
  end
end
