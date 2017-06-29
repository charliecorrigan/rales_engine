require 'rails_helper'

describe 'Transactions API' do
  context 'GET /api/v1/transaction/random' do
    it 'returns a random transaction' do
      transactions = create_list(:transaction, 3)
      ids = transactions.map(&:id)

      get "/api/v1/transactions/random"

      raw_transaction = JSON.parse(response.body)

      expect(ids.include?(raw_transaction['id'])).to be true
    end
  end
end