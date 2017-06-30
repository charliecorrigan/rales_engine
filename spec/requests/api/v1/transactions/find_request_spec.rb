require 'rails_helper'

describe 'Transactions Find API' do
  let(:transactions) { create_list(:transaction, 3) }
  
  context "GET /api/v1/transactions/find?credit_card_number=?" do
    it "sends first transaction with included credit_card_number" do
      transaction1 = create(:transaction, credit_card_number: "1234567812345678")
      transaction2 = create(:transaction, credit_card_number: "4444333322221111")

      get "/api/v1/transactions/find?credit_card_number=#{transaction1.credit_card_number}"

      expect(response).to be_success
      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transaction1.id)
    end
  end

  context "GET /api/v1/transactions/find?invoice_id=?" do
    it "sends first transaction with included invoice_id" do

      get "/api/v1/transactions/find?invoice_id=#{transactions.first.invoice.id}"

      expect(response).to be_success
      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transactions.first.id)
    end
  end

  context "GET /api/v1/transactions/find?result=?" do
    it "sends first transaction with included result" do
      transaction1 = create(:transaction, result: "success")
      create_list(:transaction, 2, result: "failure")

      get "/api/v1/transactions/find?result=#{transaction1.result}"

      expect(response).to be_success
      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transaction1.id)
    end
  end

  context "GET /api/v1/transactions/find?id=?" do
    it "sends first transaction with included id" do

      get "/api/v1/transactions/find?id=#{transactions.first.id}"
      expect(response).to be_success

      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transactions.first.id)
    end
  end

  context "GET /api/v1/transactions/find?created_at=?" do
    it "sends first transaction with included created_at" do
      transaction1 = create(:transaction, created_at: "2012-03-27T14:56:35.000Z")
      create(:transaction)

      get "/api/v1/transactions/find?created_at=#{transaction1.created_at}"
      expect(response).to be_success

      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transaction1.id)
    end
  end

  context "GET /api/v1/transactions/find?updated_at=?" do
    it "sends first transaction with included updated_at" do
      transaction1 = create(:transaction, updated_at: "2012-03-27T14:56:35.000Z")
      create(:transaction)

      get "/api/v1/transactions/find?updated_at=#{transaction1.updated_at}"
      expect(response).to be_success

      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transaction1.id)
    end
  end
end
