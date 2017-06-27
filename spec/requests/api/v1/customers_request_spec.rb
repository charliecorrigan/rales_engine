require 'rails_helper'

describe "Customers API" do
  context "GET /api/v1/customers" do
    it "sends a list of customers" do
      create_list(:customers, 3)

      get '/api/v1/customers'

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(3)
    end
  end
end
