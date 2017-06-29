require 'rails_helper'

describe "BI API - Merchant Revenue for Date" do
  context 'GET /api/v1/merchants/revenue?date=x' do
    let (:merchants) { create_list(:merchant, 2) }

    let (:m0_invoice) { create(:invoice, merchant: merchants[0]) }
    let! (:m0_invoiceitems) { create_list(:invoice_item, 3, invoice: m0_invoice, created_at: '2012-03-16 11:55:05')}

    let (:m1_invoice) { create(:invoice, merchant: merchants[1]) }
    let! (:m1_invoiceitems_on_date) { create_list(:invoice_item, 3, invoice: m1_invoice, created_at: '2012-03-16 11:55:05')}
    let! (:m1_invoiceitems_off_date) { create_list(:invoice_item, 3, invoice: m1_invoice)}

    it 'returns the total revenue for date x across all merchants' do
      get '/api/v1/merchants/revenue?date=2012-03-16 11:55:05'

      expect(response).to be_success

      total_revenue = JSON.parse(response.body)

      expect(total_revenue).to have_key("total_revenue")
      expect(total_revenue["total_revenue"]).to eq 6
    end
  end
end
