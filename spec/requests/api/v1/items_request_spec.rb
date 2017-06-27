require 'rails_helper'

describe 'Items API' do
  context 'GET /api/v1/items' do
    it 'sends a list of all items' do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first

      expect(raw_items.count).to be 3

      expect(raw_item).to have_key('name')
      expect(raw_item['name']).to be_a String

      expect(raw_item).to have_key('description')
      expect(raw_item['description']).to be_a String

      expect(raw_item).to have_key('unit_price')
      expect(raw_item['unit_price']).to be_a Integer

      expect(raw_item).to have_key('merchant_id')
      expect(raw_item['merchant_id']).to be_a Integer

      expect(raw_item).to have_key('created_at')
      expect(raw_item['created_at']).to be_a String
      expect(raw_item).to have_key('updated_at')
      expect(raw_item['updated_at']).to be_a String
    end

    it 'does not respond to /v2/'
  end

  context 'GET /api/v1/items/:id' do
    it 'sends the information about one item' do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      raw_item = JSON.parse(response.body)

      expect(raw_item['id']).to eq item.id
      expect(raw_item).to have_key('name')
      expect(raw_item['name']).to be_a String

      expect(raw_item).to have_key('description')
      expect(raw_item['description']).to be_a String

      expect(raw_item).to have_key('unit_price')
      expect(raw_item['unit_price']).to be_a Integer

      expect(raw_item).to have_key('merchant_id')
      expect(raw_item['merchant_id']).to be_a Integer

      expect(raw_item).to have_key('created_at')
      expect(raw_item['created_at']).to be_a String
      expect(raw_item).to have_key('updated_at')
      expect(raw_item['updated_at']).to be_a String
    end
  end

  xcontext 'GET /api/v1/invoice/random' do
    it 'returns a random invoice' do
      invoices = create_list(:item, 3)
      ids = invoices.map(&:id)

      get "/api/v1/items/random"

      raw_item = JSON.parse(response.body)

      expect(ids.include?(raw_item['id'])).to be true
    end
  end
end
