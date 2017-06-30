require 'rails_helper'

describe 'Items API' do
  context 'GET /api/v1/invoice/random' do
    it 'returns a random invoice' do
      invoices = create_list(:invoice, 3)
      ids = invoices.map(&:id)

      get "/api/v1/invoices/random"

      raw_invoice = JSON.parse(response.body)

      expect(ids.include?(raw_invoice['id'])).to be true
    end
  end
end
