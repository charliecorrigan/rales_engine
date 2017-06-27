require 'rails_helper'

describe 'Items API' do
  context 'GET /api/v1/item/random' do
    it 'returns a random item' do
      items = create_list(:item, 3)
      ids = items.map(&:id)

      get "/api/v1/items/random"

      raw_item = JSON.parse(response.body)

      expect(ids.include?(raw_item['id'])).to be true
    end
  end
end
