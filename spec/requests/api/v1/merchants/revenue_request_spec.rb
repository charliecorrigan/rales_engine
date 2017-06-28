require 'rails_helper'

describe "Merchants Revenue API" do
  context 'GET /api/v1/merchants/:id/revenue' do
    it "sends the total revenue of a single merchant" do
      merchant1 = create(:merchant, id: 1)
      create(:invoice_with_invoice_items, merchant_id: 1)

      get "/api/v1/merchants/#{merchant1.id}/revenue"

      expect(response).to be_success
    end
  end
end
