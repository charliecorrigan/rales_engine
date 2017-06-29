require 'rails_helper'

describe "Item Best Day API" do
  context 'GET /api/v1/items/:id/best_day' do
    it "returns the date with the most sales for the given item" do
      item1 = create(:item)

      invoice1 = create(:invoice, created_at: "2017-06-28 00:00:00")
      invoice2 = create(:invoice, created_at: "2017-01-21 00:00:00")
      create(:transaction, invoice: invoice1)
      create(:transaction, invoice: invoice2)
      create(:invoice_item, invoice: invoice1, item: item1)
      create(:invoice_item, invoice: invoice1, item: item1)
      create(:invoice_item, invoice: invoice2, item: item1)
      create(:invoice_item, invoice: invoice2, item: item1)
      create(:invoice_item, invoice: invoice2, item: item1)
      create(:invoice_item, invoice: invoice2, item: item1)

      get "/api/v1/items/#{item1.id}/best_day"

      expect(response).to be_success

      result = JSON.parse(response.body)

      expect(result).to have_key("best_day")
      expect(result["best_day"]).to eq("2017-01-21 00:00:00")
    end
  end
end