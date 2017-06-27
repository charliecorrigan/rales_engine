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

  context "GET /api/v1/transactions/:id" do
    it "sends a single transaction by id" do
      id = create(:transaction).id

      get "/api/v1/transactions/#{id}"

      expect(response).to be_success

      transaction = JSON.parse(response.body)

      expect(transaction["id"]).to eq(id)
      # expect(transaction).to have_key("invoice_id")
      expect(transaction).to have_key("credit_card_number")
      expect(transaction).to have_key("result")
    end
  end
end
