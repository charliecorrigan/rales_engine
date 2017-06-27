require 'rails_helper'

describe 'Invoice_Items API' do
  context 'GET /api/v1/invoice_item/random' do
    it 'returns a random invoice_item' do
      invoice_items = create_list(:invoice_item, 3)
      ids = invoice_items.map(&:id)

      get "/api/v1/invoice_items/random"

      raw_invoice_item = JSON.parse(response.body)

      expect(ids.include?(raw_invoice_item['id'])).to be true
    end
  end
end
