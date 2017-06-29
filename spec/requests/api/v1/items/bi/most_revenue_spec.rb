require 'rails_helper'

describe "BI API - X Items with Most Revenue" do
  context 'GET /api/v1/items/most_revenue?quantity=x' do
    let(:items) { create_list(:item, 3) }
    let!(:invoice_item0) { create(:invoice_item, item: items[0], quantity: 3) }
    let!(:invoice_item1) { create(:invoice_item, item: items[1], quantity: 2) }
    let!(:invoice_item2) { create(:invoice_item, item: items[2], quantity: 1) }

    it "returns the top 2 items ranked by total revenue generated" do
      get '/api/v1/items/most_revenue?quantity=2'

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      item_ids = raw_items.map{ |i| i['id'] }

      expect(raw_items).to be_a Array
      expect(raw_items.length).to eq 2
      expect(item_ids.include?(items[0].id)).to be true
      expect(item_ids.include?(items[1].id)).to be true
      expect(item_ids.include?(items[2].id)).to be false
    end
  end
end
