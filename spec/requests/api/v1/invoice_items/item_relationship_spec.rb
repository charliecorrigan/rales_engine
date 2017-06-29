require 'rails_helper'

describe 'Invoice_item Item API' do
  let(:item) { create(:item) }
  let!(:invoice_item) { create(:invoice_item, item: item)}
  context 'GET /api/v1/invoice_items/:id/item' do
    it 'returns the associated item' do
      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      expect(response).to be_success

      raw_item = JSON.parse(response.body)

      expect(raw_item).to have_key('id')
      expect(raw_item['id']).to be_a Integer
      expect(raw_item).to have_key('name')
      expect(raw_item['name']).to be_a String

      expect(raw_item['id']).to eq item.id
    end
  end
end
