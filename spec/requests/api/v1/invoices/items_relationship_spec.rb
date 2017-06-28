require 'rails_helper'

describe 'Invoice Items API' do
  let(:invoice) { create(:invoice) }
  let!(:items) { create_list(:item, 3, invoice: invoice)}
  let!(:other_item) { create(:item) }
  context 'GET /api/v1/invoices/:id/items' do
    it 'returns a collection of items for that invoice' do
      get "/api/v1/invoices/#{invoice.id}/items"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first

      expect(raw_items.count).to be 3

      expect(raw_item).to have_key('id')
      expect(raw_item['id']).to be_a Integer

      expect(raw_item).to have_key('merchant_id')
      expect(raw_item['merchant_id']).to be_a Integer

      expect(raw_item).to have_key('unit_price')
      expect(raw_item['unit_price']).to be_a String

      expect(raw_item).to have_key('name')
      expect(raw_item['name']).to be_a String

      expect(raw_item).to have_key('description')
      expect(raw_item['description']).to be_a String
    end
  end
end