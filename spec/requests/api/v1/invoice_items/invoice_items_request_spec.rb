require 'rails_helper'

describe 'Invoice_Items API' do
  context 'GET /api/v1/invoice_items' do
    it 'sends a list of all items' do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items'

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first

      expect(raw_invoice_items.count).to be 3

      expect(raw_invoice_item).to have_key('item_id')
      expect(raw_invoice_item['item_id']).to be_a Integer

      expect(raw_invoice_item).to have_key('invoice_id')
      expect(raw_invoice_item['invoice_id']).to be_a Integer

      expect(raw_invoice_item).to have_key('quantity')
      expect(raw_invoice_item['quantity']).to be_a Integer

      expect(raw_invoice_item).to have_key('unit_price')
      expect(raw_invoice_item['unit_price']).to be_a String
    end
  end

  context 'GET /api/v1/invoice_items/:id' do
    it 'sends the information about one invoice_item' do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item.id}"

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item).to have_key('item_id')
      expect(raw_invoice_item['item_id']).to be_a Integer

      expect(raw_invoice_item).to have_key('invoice_id')
      expect(raw_invoice_item['invoice_id']).to be_a Integer

      expect(raw_invoice_item).to have_key('quantity')
      expect(raw_invoice_item['quantity']).to be_a Integer

      expect(raw_invoice_item).to have_key('unit_price')
      expect(raw_invoice_item['unit_price']).to be_a String
    end
  end
end
