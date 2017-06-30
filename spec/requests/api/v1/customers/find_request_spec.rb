require 'rails_helper'

describe 'Customers Find API' do
  context "GET /api/v1/customers/find?first_name=?" do
    it "sends first customer with included first name" do
      customer1 = create(:customer, first_name: "Bob")
      customer2 = create(:customer, first_name: "Rob")
      customer3 = create(:customer, first_name: "Bill")
      get "/api/v1/customers/find?first_name=#{customer1.first_name}"

      expect(response).to be_success
      customer_result = JSON.parse(response.body)

      expect(customer_result["id"]).to eq(customer1.id)
    end
  end

  context "GET /api/v1/customers/find?id=?" do
    it "sends first customer with included id" do
      customers = create_list(:customer, 3)

      get "/api/v1/customers/find?id=#{customers.first.id}"
      expect(response).to be_success

      customer_result = JSON.parse(response.body)

      expect(customer_result["id"]).to eq(customers.first.id)
    end
  end

  context "GET /api/v1/customers/find?last_name=?" do
    it "sends first customer with included last name" do
      customer1 = create(:customer, last_name: "Bob")
      customer2 = create(:customer, last_name: "Bob")
      customer3 = create(:customer, last_name: "Bill")

      get "/api/v1/customers/find?last_name=#{customer1.last_name}"

      expect(response).to be_success

      customer_result = JSON.parse(response.body)

      expect(customer_result["id"]).to eq(customer1.id)
    end
  end

  context "GET /api/v1/customers/find?created_at=?" do
    it "sends first customer with included created_at" do
      customer1 = create(:customer, created_at: "2012-03-27T14:56:35.000Z")
      create(:customer)
      create(:customer)
      create(:customer)

      get "/api/v1/customers/find?created_at=#{customer1.created_at}"
      expect(response).to be_success

      customer_result = JSON.parse(response.body)

      expect(customer_result["id"]).to eq(customer1.id)
    end
  end

  context "GET /api/v1/customers/find?updated_at=?" do
    it "sends first customer with included updated_at" do
      customer1 = create(:customer, updated_at: "2012-03-27T14:56:35.000Z")
      create(:customer)
      create(:customer)
      create(:customer)

      get "/api/v1/customers/find?updated_at=#{customer1.updated_at}"
      expect(response).to be_success

      customer_result = JSON.parse(response.body)

      expect(customer_result["id"]).to eq(customer1.id)
    end
  end
end
