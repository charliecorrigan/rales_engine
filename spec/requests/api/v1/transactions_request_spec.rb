require 'rails_helper'

describe "Transactions API" do
  context "GET /api/v1/transactions" do
    it "sends a list of transactions" do
      create_list(:transaction, 3)

      get '/api/v1/transactions'

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(3)
    end
  end
end
