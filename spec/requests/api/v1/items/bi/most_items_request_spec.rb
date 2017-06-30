require 'rails_helper'

describe "Item Most Items API" do
  context 'GET /api/v1/items/most_items?quantity=x' do
    it "returns the top x item instances ranked by total number sold" do
      items = create_list(:item, 3)
      
      invoice1 = create(:invoice, :with_transactions)

      create_list(:invoice_item, 2, invoice: invoice1, item:items[0])
      create_list(:invoice_item, 3, invoice: invoice1, item:items[1])
      create(:invoice_item, invoice: invoice1, item: items[2])

      get "/api/v1/items/most_items?quantity=2"

      expect(response).to be_success

      result = JSON.parse(response.body)

      item_ids = result.map{ |i| i['id'] }

      expect(result).to be_a Array
      expect(result.length).to eq 2
      expect(item_ids.include?(items[0].id)).to be true
      expect(item_ids.include?(items[1].id)).to be true
      expect(item_ids.include?(items[2].id)).to be false
      expect(result.first["id"]).to eq(items[1].id)
    end
  end
end
