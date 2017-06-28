require 'rails_helper'

describe 'Merchants API' do
  context 'GET /api/v1/merchant/random' do
    it 'returns a random merchant' do
      merchants = create_list(:merchant, 3)
      ids = merchants.map(&:id)

      get "/api/v1/merchants/random"

      raw_merchant = JSON.parse(response.body)

      expect(ids.include?(raw_merchant['id'])).to be true
    end
  end
end