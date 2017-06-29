require 'rails_helper'

describe "Merchants Revenue API" do
  context 'GET /api/v1/merchants/:id/revenue' do
    it "sends the total revenue of a single merchant" do
      merchant1 = create(:merchant, id: 1)
      invoice1 = create(:invoice, merchant: merchant1)
      invoice_items1 = create(:invoice_item, invoice: invoice1)
      invoice_items2 = create(:invoice_item, quantity: 2, invoice: invoice1)
      create(:transaction, invoice: invoice1)
      get "/api/v1/merchants/#{merchant1.id}/revenue"

      expect(response).to be_success

      revenue_result = JSON.parse(response.body)

      expect(revenue_result).to eq({"revenue"=>"0.03"})
    end
  end

    context 'GET /api/v1/merchants/:id/revenue' do
    it "sends the total revenue of a single merchant" do
      merchant1 = create(:merchant, id: 1)
      invoice1 = create(:invoice, merchant: merchant1, created_at: "2017-06-28 00:00:00")
      invoice_items1 = create(:invoice_item, invoice: invoice1)
      invoice_items2 = create(:invoice_item, quantity: 2, invoice: invoice1)
      create(:transaction, invoice: invoice1)
      invoice2 = create(:invoice, merchant: merchant1, created_at: "2017-06-29 00:00:00")
      invoice_items1 = create(:invoice_item, invoice: invoice2)
      invoice_items2 = create(:invoice_item, quantity: 2, invoice: invoice2)
      create(:transaction, invoice: invoice2)
      get "/api/v1/merchants/#{merchant1.id}/revenue?date=2017-06-28 00:00:00"

      expect(response).to be_success

      revenue_result = JSON.parse(response.body)

      expect(revenue_result).to eq({"revenue"=>"0.03"})
    end
  end
end
