require 'rails_helper'

describe 'Invoices Find All API' do
  context 'GET /api/v1/invoices/find_all' do
    context '?id=' do
      it 'returns all invoices with that primary key' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find_all?id=#{invoice.id}"

        raw_invoices = JSON.parse(response.body)
        raw_invoice = raw_invoices.first

        expect(response).to be_success
        expect(raw_invoices.count).to be 1
        expect(raw_invoice["id"]).to eq(invoice.id)
      end

      it 'returns [] when no primary key' do

        get "/api/v1/invoices/find_all?id=1"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_a Array
        expect(raw_invoice.length).to eq 0
      end
    end

    context '?customer_id=' do
      it 'returns all invoices with that customer_id' do
        customer = create(:customer)
        invoices = create_list(:invoice, 2, customer: customer)

        get "/api/v1/invoices/find_all?customer_id=#{invoices.first.customer_id}"

        raw_invoices = JSON.parse(response.body)
        raw_invoice = raw_invoices.first

        expect(response).to be_success
        expect(raw_invoices.count).to be 2
        expect(raw_invoice["id"]).to eq(invoices.first.id)
      end

      it 'returns [] when no customer_id found' do

        get "/api/v1/invoices/find_all?customer_id=1"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_a Array
        expect(raw_invoice.length).to eq 0
      end
    end

    context '?merchant_id=' do
      it 'returns all invoices with that merchant_id' do
        merchant = create(:merchant)
        invoices = create_list(:invoice, 3, merchant: merchant)

        get "/api/v1/invoices/find_all?merchant_id=#{invoices.first.merchant_id}"

        raw_invoices = JSON.parse(response.body)
        raw_invoice = raw_invoices.first

        expect(response).to be_success
        expect(raw_invoices.count).to be 3
        expect(raw_invoice["id"]).to eq(invoices.first.id)
      end

      it 'returns [] when no merchant_id found' do

        get "/api/v1/invoices/find_all?merchant_id=1"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_a Array
        expect(raw_invoice.length).to eq 0
      end
    end

    context '?status=' do
      it 'returns all invoices with that status' do
        invoices = create_list(:invoice, 2)

        get "/api/v1/invoices/find_all?status=#{invoices.first.status}"

        raw_invoices = JSON.parse(response.body)
        raw_invoice = raw_invoices.first

        expect(response).to be_success
        expect(raw_invoices.count).to be 2
        expect(raw_invoice["id"]).to eq(invoices.first.id)
      end

      it 'returns [] when no status found' do

        get "/api/v1/invoices/find_all?status=1"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_a Array
        expect(raw_invoice.length).to eq 0
      end
    end

    context '?created_at=' do
      it 'returns all invoices with that created_at' do
        invoice = create(:invoice)
        create(:invoice)
        create(:invoice)
        create(:invoice, created_at: "2013-03-09 08:57:21")

        get "/api/v1/invoices/find_all?created_at=#{invoice.created_at}"

        raw_invoices = JSON.parse(response.body)
        raw_invoice = raw_invoices.first

        expect(response).to be_success
        expect(raw_invoices.count).to be 3
        expect(raw_invoice["id"]).to eq(invoice.id)
      end

      it 'returns [] when no created_at found' do

        get "/api/v1/invoices/find_all?created_at=2013-03-09 08:57:21"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_a Array
        expect(raw_invoice.length).to eq 0
      end
    end

    context '?updated_at=' do
      it 'returns all invoices with that updated_at' do
        invoice = create(:invoice)
        create(:invoice)
        create(:invoice)
        create(:invoice, updated_at: "2013-03-09 08:57:21")

        get "/api/v1/invoices/find_all?updated_at=#{invoice.updated_at}"

        raw_invoices = JSON.parse(response.body)
        raw_invoice = raw_invoices.first

        expect(response).to be_success
        expect(raw_invoices.count).to be 3
        expect(raw_invoice["id"]).to eq(invoice.id)
      end

      it 'returns [] when no updated_at found' do

        get "/api/v1/invoices/find_all?updated_at=2013-03-09 08:57:21"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_a Array
        expect(raw_invoice.length).to eq 0
      end
    end
  end
end
