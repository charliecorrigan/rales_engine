require 'rails_helper'

describe 'BI API - Customers with Pending Invoices' do
  context 'GET /api/v1/merchants/:id/customers_with_pending_invoices' do
    let (:merchant) { create(:merchant) }
    let (:customers) { create_list(:customer, 2) }

    let (:c0_invoices) { create_list(:invoice, 3, merchant: merchant, customer: customers[0]) }
    let! (:c0i_transactions) do
      c0_invoices.map do |invoice|
        create(:transaction, result: 'failed', invoice: invoice)
      end
    end

    let (:c1_invoice) { create(:invoice, merchant: merchant, customer: customers[1]) }
    let! (:c1i_transactions) { create(:transaction, result: 'failed', invoice: c1_invoice) }
    let (:not_pending_invoice) { create(:invoice,  merchant: merchant, customer: customers[1]) }
    let! (:npi_transaction_success) { create(:transaction, result: 'success', invoice: not_pending_invoice) }

    it 'returns an array of customers with pending invoices' do
      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      expect(response).to be_success

      raw_customers = JSON.parse(response.body)
      customer_ids = raw_customers.map{ |c| c['id'] }

      expect(raw_customers).to be_a Array
      expect(raw_customers.length).to eq 1
      expect(customer_ids.include?(customers[0].id)).to be true
      expect(customer_ids.include?(customers[1].id)).to be false
    end
  end
end
