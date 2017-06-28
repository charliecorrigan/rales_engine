require 'rails_helper'

describe "Merchants Revenue API" do
  context 'GET /api/v1/merchants/:id/revenue' do
    it "sends the total revenue of a single merchant" do
      merchant1 = create(:merchant, id: 1)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)
      invoice1 = create(:invoice, merchant: merchant1)
      invoice_items1 = create(:invoice_item, item: item1, invoice: invoice1)
      invoice_items2 = create(:invoice_item, item: item2, quantity: 2, invoice: invoice1)

      get "/api/v1/merchants/#{merchant1.id}/revenue"

      expect(response).to be_success

      revenue_result = JSON.parse(response.body)

      expect(revenue_result).to eq({"revenue"=>3})
    end
  end
end
