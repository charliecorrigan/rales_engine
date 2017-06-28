require 'rails_helper'

describe 'Customers API' do
  context 'GET /api/v1/customer/random' do
    it 'returns a random customer' do
      customers = create_list(:customer, 3)
      ids = customers.map(&:id)

      get "/api/v1/customers/random"

      raw_customer = JSON.parse(response.body)

      expect(ids.include?(raw_customer['id'])).to be true
    end
  end
end