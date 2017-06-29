require 'rails_helper'

describe "Item Most Items API" do
  context 'GET /api/v1/items/most_items?quantity=x' do
    it "returns the top x item instances ranked by total number sold" do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)


      invoice1 = create(:invoice)
      create(:transaction, invoice: invoice1)

      create(:invoice_item, invoice: invoice1, item: item1)
      create(:invoice_item, invoice: invoice1, item: item1)
      create(:invoice_item, invoice: invoice1, item: item2)
      create(:invoice_item, invoice: invoice1, item: item2)
      create(:invoice_item, invoice: invoice1, item: item2)
      create(:invoice_item, invoice: invoice1, item: item3)

      get "/api/v1/items/most_items?quantity=2"

      expect(response).to be_success

      result = JSON.parse(response.body)

      item_ids = result.map{ |i| i['id'] }

      expect(result).to be_a Array
      expect(result.length).to eq 2
      expect(item_ids.include?(item1.id)).to be true
      expect(item_ids.include?(item1.id)).to be true
      expect(item_ids.include?(item3.id)).to be false
      expect(result.first.id).to eq(item2.id)
    end
  end
end