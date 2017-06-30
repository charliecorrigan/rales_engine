require 'rails_helper'

describe 'Transactions Find All API' do
  context "GET /api/v1/transactions/find_all?credit_card_number=?" do
    it "sends a list of transactions with included credit_card_number" do
      transaction1 = create(:transaction, credit_card_number: "1234567812345678")
      transaction2 = create(:transaction, credit_card_number: "1234567812345678")
      transaction3 = create(:transaction, credit_card_number: "1111222233334444")

      get "/api/v1/transactions/find_all?credit_card_number=#{transaction1.credit_card_number}"

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(2)
    end
  end

  context "GET /api/v1/transactions/find_all?invoice_id=?" do
    it "sends a list of transactions with included invoice_id" do
      invoices = create_list(:invoice, 2, :with_transactions, transaction_count: 2)

      get "/api/v1/transactions/find_all?invoice_id=#{invoices.first.id}"

      expect(response).to be_success

      transactions = JSON.parse(response.body)


      expect(transactions.count).to eq(2)
      expect(transactions.first["id"]).to eq invoices.first.transactions.first.id
    end
  end

   context "GET /api/v1/transactions/find_all?result=?" do
    it "sends a list of transactions with included result" do
      transaction_list = create_list(:transaction, 3)
      failed_transaction = create(:transaction, result: "failure")

      get "/api/v1/transactions/find_all?result=success"

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transaction_list.count).to eq(3)
    end
  end

  context "GET /api/v1/transactions/find_all?id=?" do
    it "sends a list of transactions with included id" do
      transactions = create_list(:transaction, 3)
      get "/api/v1/transactions/find_all?id=#{transactions.first.id}"

      expect(response).to be_success

      transaction_results = JSON.parse(response.body)

      expect(transaction_results.count).to eq(1)
    end
  end

  context "GET /api/v1/transactions/find_all?created_at=?" do
    it "sends a list of transactions with included created_at" do
      transactions = create_list(:transaction, 3, created_at: "2012-03-27T14:56:35.000Z")

      create(:transaction)

      get "/api/v1/transactions/find_all?created_at=#{transactions.first.created_at}"
      expect(response).to be_success

      transaction_results = JSON.parse(response.body)

      expect(transaction_results.count).to eq(3)
    end
  end

  context "GET /api/v1/transactions/find_all?updated_at=?" do
    it "sends a list of transactions with included updated_at" do
      transactions = create_list(:transaction, 3, updated_at: "2012-03-27T14:56:35.000Z")

      create(:transaction)

      get "/api/v1/transactions/find_all?updated_at=#{transactions.first.updated_at}"
      expect(response).to be_success

      transaction_results = JSON.parse(response.body)

      expect(transaction_results.count).to eq(3)
    end
  end
end
