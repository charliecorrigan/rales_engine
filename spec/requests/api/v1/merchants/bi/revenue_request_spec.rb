require 'rails_helper'

describe "Merchants Revenue API" do
  let(:merchant1) { create(:merchant) }
  let(:invoice1) { create(:invoice, :with_transactions, merchant: merchant1, created_at: "2017-06-28 00:00:00") }
  let(:invoice2) { create(:invoice, :with_transactions, merchant: merchant1, created_at: "2017-06-29 00:00:00") }

  before do
    create_list(:invoice_item, 3, invoice: invoice1)
    create_list(:invoice_item, 3, invoice: invoice2)
  end

  context 'GET /api/v1/merchants/:id/revenue' do
    it "sends the total revenue of a single merchant" do
      get "/api/v1/merchants/#{merchant1.id}/revenue"

      expect(response).to be_success

      revenue_result = JSON.parse(response.body)

      expect(revenue_result).to eq({"revenue"=>"0.06"})
    end
  end

  context 'GET /api/v1/merchants/:id/revenue?date=x' do
    it "sends the total revenue of a single merchant on a specific date" do
      get "/api/v1/merchants/#{merchant1.id}/revenue?date=2017-06-28 00:00:00"

      expect(response).to be_success

      revenue_result = JSON.parse(response.body)

      expect(revenue_result).to eq({"revenue"=>"0.03"})
    end
  end
end
