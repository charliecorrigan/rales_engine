require 'rails_helper'

describe 'Items InvoiceItems API' do
  let(:item) { create(:item) }
  let!(:invoice_items) { create_list(:invoice_item, 3, item: item)}
  let!(:other_invoice_item) { create(:invoice_item) }
  context 'GET /api/v1/items/:id/invoice_items' do
    it 'returns a collection of invoice_items for that item' do
      get "/api/v1/items/#{item.id}/invoice_items"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first

      expect(raw_invoice_items.count).to be 3

      expect(raw_invoice_item).to have_key('quantity')
      expect(raw_invoice_item['quantity']).to be_a Integer

      expect(raw_invoice_item).to have_key('invoice_id')
      expect(raw_invoice_item['invoice_id']).to be_a Integer

      expect(raw_invoice_item).to have_key('unit_price')
      expect(raw_invoice_item['unit_price']).to be_a String

      expect(raw_invoice_item).to have_key('item_id')
      expect(raw_invoice_item['item_id']).to be_a Integer
      expect(raw_invoice_item['item_id']).to eq item.id
    end
  end
end