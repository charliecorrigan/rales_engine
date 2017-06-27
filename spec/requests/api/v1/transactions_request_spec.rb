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
      expect(transaction).to have_key("invoice_id")
      expect(transaction).to have_key("credit_card_number")
      expect(transaction).to have_key("result")
    end
  end

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
      invoice1 = create(:invoice, id: 1)
      invoice2 = create(:invoice, id: 2)

      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice1.id)
      transaction3 = create(:transaction, invoice_id: invoice2.id)
      get "/api/v1/transactions/find_all?invoice_id=#{transaction1.invoice_id}"

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(2)
    end
  end

   context "GET /api/v1/transactions/find_all?result=?" do
    it "sends a list of transactions with included result" do
      transaction1 = create(:transaction, result: "success")
      transaction2 = create(:transaction, result: "success")
      transaction3 = create(:transaction, result: "failure")

      get "/api/v1/transactions/find_all?result=#{transaction1.result}"

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(2)
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
      transaction1 = create(:transaction, created_at: "2012-03-27T14:56:35.000Z")
      create(:transaction, created_at: "2012-03-27T14:56:35.000Z")
      create(:transaction, created_at: "2012-03-27T14:56:35.000Z")
      create(:transaction)

      get "/api/v1/transactions/find_all?created_at=#{transaction1.created_at}"
      expect(response).to be_success

      transaction_results = JSON.parse(response.body)

      expect(transaction_results.count).to eq(3)
    end
  end

  context "GET /api/v1/transactions/find_all?updated_at=?" do
    it "sends a list of transactions with included updated_at" do
      transaction1 = create(:transaction, updated_at: "2012-03-27T14:56:35.000Z")
      create(:transaction, updated_at: "2012-03-27T14:56:35.000Z")
      create(:transaction, updated_at: "2012-03-27T14:56:35.000Z")
      create(:transaction)

      get "/api/v1/transactions/find_all?updated_at=#{transaction1.updated_at}"
      expect(response).to be_success

      transaction_results = JSON.parse(response.body)

      expect(transaction_results.count).to eq(3)
    end
  end

  context "GET /api/v1/transactions/find?credit_card_number=?" do
    it "sends first transaction with included credit_card_number" do
      transaction1 = create(:transaction, credit_card_number: "1234567812345678")
      transaction2 = create(:transaction, credit_card_number: "4444333322221111")
      transaction3 = create(:transaction, credit_card_number: "1111222233334444")
      get "/api/v1/transactions/find?credit_card_number=#{transaction1.credit_card_number}"

      expect(response).to be_success
      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transaction1.id)
    end
  end

  context "GET /api/v1/transactions/find?invoice_id=?" do
    it "sends first transaction with included invoice_id" do
      transaction1 = create(:transaction)
      transaction2 = create(:transaction)
      transaction3 = create(:transaction)
      get "/api/v1/transactions/find?invoice_id=#{transaction1.invoice_id}"

      expect(response).to be_success
      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transaction1.id)
    end
  end

  context "GET /api/v1/transactions/find?result=?" do
    it "sends first transaction with included result" do
      transaction1 = create(:transaction, result: "success")
      transaction2 = create(:transaction, result: "failure")
      transaction3 = create(:transaction, result: "failure")
      get "/api/v1/transactions/find?result=#{transaction1.result}"

      expect(response).to be_success
      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transaction1.id)
    end
  end

  context "GET /api/v1/transactions/find?id=?" do
    it "sends first transaction with included id" do
      transactions = create_list(:transaction, 3)

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
      create(:transaction)
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
      create(:transaction)
      create(:transaction)

      get "/api/v1/transactions/find?updated_at=#{transaction1.updated_at}"
      expect(response).to be_success

      transaction_result = JSON.parse(response.body)

      expect(transaction_result["id"]).to eq(transaction1.id)
    end
  end
end
