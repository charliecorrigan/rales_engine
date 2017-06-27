require 'rails_helper'

describe "Customers API" do
  context "GET /api/v1/customers" do
    it "sends a list of customers" do
      create_list(:customer, 3)

      get '/api/v1/customers'

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(3)
    end
  end

  context "GET /api/v1/customers/:id" do
    it "sends a single customer by its id" do
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      expect(result).to be_success

      customer = JSON.parse(result.body)

      expect(customer["id"]).to eq(id)
      expect(customer).to have_key("first_name")
      expect(customer).to have_key("last_name")
    end
  end
end
