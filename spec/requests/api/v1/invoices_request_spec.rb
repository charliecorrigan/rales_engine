require 'rails_helper'

describe 'Invoices API' do
  context 'GET /api/v1/invoices' do
    it 'sends a list of all invoices' do
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first

      expect(raw_invoices.count).to be 3
      expect(raw_invoice).to have_key('customer_id')
      expect(raw_invoice['customer_id']).to be_a Integer
      expect(raw_invoice).to have_key('merchant_id')
      expect(raw_invoice['merchant_id']).to be_a Integer
      expect(raw_invoice).to have_key('status')
      expect(raw_invoice['status']).to be_a String
      expect(raw_invoice).to have_key('created_at')
      expect(raw_invoice['created_at']).to be_a String
      expect(raw_invoice).to have_key('updated_at')
      expect(raw_invoice['updated_at']).to be_a String
    end

    it 'does not respond to /v2/'
  end

  context 'GET /api/v1/invoices/:id' do
    it 'sends the information about one invoice' do
      invoice = create(:invoice)

      get "/api/v1/invoices/#{invoice.id}"

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice['id']).to eq invoice.id
      expect(raw_invoice).to have_key('customer_id')
      expect(raw_invoice['customer_id']).to be_a Integer
      expect(raw_invoice['customer_id']).to eq invoice.customer_id
      expect(raw_invoice).to have_key('merchant_id')
      expect(raw_invoice['merchant_id']).to be_a Integer
      expect(raw_invoice['merchant_id']).to eq invoice.merchant_id
      expect(raw_invoice).to have_key('status')
      expect(raw_invoice['status']).to be_a String
      expect(raw_invoice['status']).to eq invoice.status
      expect(raw_invoice).to have_key('created_at')
      expect(raw_invoice['created_at']).to be_a String
      expect(raw_invoice['created_at']).to eq invoice.created_at.strftime('%FT%T.%LZ')
      expect(raw_invoice).to have_key('updated_at')
      expect(raw_invoice['updated_at']).to be_a String
      expect(raw_invoice['updated_at']).to eq invoice.updated_at.strftime('%FT%T.%LZ')
    end
  end

  context 'GET /api/v1/invoices/find' do
    context '?id=' do
      it 'returns the invoice with that primary key' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?id=#{invoice.id}"

        raw_invoice = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end

      it 'returns returns empty when no primary key'
    end
    context '?customer_id=' do
      it 'returns the first invoice with that customer_id' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

        raw_invoice = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end
    end
    context '?merchant_id=' do
      it 'returns the first invoice with that merchant_id' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

        raw_invoice = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end
    end
    context '?status=' do
      it 'returns the first invoice with that status' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?status=#{invoice.status}"

        raw_invoice = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end
    end
    context '?created_at=' do
      xit 'returns the first invoice with that created_at'do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice['id']).to eq invoice.id

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end
    end
    context '?updated_at=' do
      xit 'returns the first invoice with that updated_at' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice['id']).to eq invoice.id

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end
    end
  end

  context 'GET /api/v1/invoices/find_all' do
    context '?id=' do
      it 'returns all invoices with that primary key'
      it 'returns returns empty when no primary key'
    end
    context '?customer_id=' do
      it 'returns all invoices with that customer_id'
    end
    context '?merchant_id=' do
      it 'returns all invoices with that merchant_id'
    end
    context '?status=' do
      it 'returns all invoices with that status'
    end
    context '?created_at=' do
      it 'returns all invoices with that created_at'
    end
    context '?updated_at=' do
      it 'returns all invoices with that updated_at'
    end
  end
end
