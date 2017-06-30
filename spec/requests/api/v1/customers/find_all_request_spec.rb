require 'rails_helper'

describe 'Customers Find All API' do
  context "GET /api/v1/customers/find_all?first_name=?" do
    it "sends a list of customers with included first name" do
      customer1 = create(:customer, first_name: "Bob")
      customer2 = create(:customer, first_name: "Bob")
      customer3 = create(:customer, first_name: "Bill")

      get "/api/v1/customers/find_all?first_name=#{customer1.first_name}"

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(2)
    end
  end

  context "GET /api/v1/customers/find_all?id=?" do
    it "sends a list of customers with included id" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/find_all?id=#{customers.first.id}"
      expect(response).to be_success

      customer_results = JSON.parse(response.body)

      expect(customer_results.count).to eq(1)
    end
  end

  context "GET /api/v1/customers/find_all?last_name=?" do
    it "sends a list of customers with included last name" do
      customer1 = create(:customer, last_name: "Bob")
      customer2 = create(:customer, last_name: "Bob")
      customer3 = create(:customer, last_name: "Bill")

      get "/api/v1/customers/find_all?last_name=#{customer1.last_name}"

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(2)
    end
  end

  context "GET /api/v1/customers/find_all?created_at=?" do
    it "sends a list of customers with included created_at" do
      customer1 = create(:customer, created_at: "2012-03-27T14:56:35.000Z")
      create(:customer, created_at: "2012-03-27T14:56:35.000Z")
      create(:customer, created_at: "2012-03-27T14:56:35.000Z")
      create(:customer)

      get "/api/v1/customers/find_all?created_at=#{customer1.created_at}"
      expect(response).to be_success

      customer_results = JSON.parse(response.body)

      expect(customer_results.count).to eq(3)
    end
  end

  context "GET /api/v1/customers/find_all?updated_at=?" do
    it "sends a list of customers with included updated_at" do
      customer1 = create(:customer, updated_at: "2012-03-27T14:56:35.000Z")
      create(:customer, updated_at: "2012-03-27T14:56:35.000Z")
      create(:customer, updated_at: "2012-03-27T14:56:35.000Z")
      create(:customer)

      get "/api/v1/customers/find_all?updated_at=#{customer1.updated_at}"
      expect(response).to be_success

      customer_results = JSON.parse(response.body)

      expect(customer_results.count).to eq(3)
    end
  end
end
