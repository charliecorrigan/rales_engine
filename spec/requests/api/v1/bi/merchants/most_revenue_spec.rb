require 'rails_helper'

describe 'BI API - X Merchants with Most Revenue' do
  context 'GET /api/v1/merchants/most_revenue?quantity=x' do
    let(:merchants) { create_list(:merchant, 3) }
    let(:m0_invoice) {create(:invoice, merchant: merchants[0])}
    let(:m1_invoice) {create(:invoice, merchant: merchants[1])}
    let(:m2_invoice) {create(:invoice, merchant: merchants[2])}

    it 'returns the top x merchants ranked by total revenue' do
      create_list(:invoice_item, 3, invoice: m0_invoice)
      create_list(:invoice_item, 2, invoice: m1_invoice)
      create_list(:invoice_item, 1, invoice: m2_invoice)

      get '/api/v1/merchants/most_revenue?quantity=2'

      expect(response).to be_success

      raw_merchants = JSON.parse(response.body)
      merchant_ids = raw_merchants.map{ |i| i['id'] }

      expect(raw_merchants).to be_a Array
      expect(raw_merchants.length).to eq 2
      expect(merchant_ids.include?(merchants[0].id)).to be true
      expect(merchant_ids.include?(merchants[1].id)).to be true
      expect(merchant_ids.include?(merchants[2].id)).to be false
    end
  end
end
