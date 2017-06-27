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
      expect(raw_invoice['created_at']).to eq invoice.created_at
      expect(raw_invoice).to have_key('updated_at')
      expect(raw_invoice['updated_at']).to be_a String
      expect(raw_invoice['updated_at']).to eq invoice.updated_at
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

      it 'returns nil when no primary key' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?id=#{invoice.id + 1}"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_nil
      end
    end

    context '?customer_id=' do
      it 'returns the first invoice with that customer_id' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

        raw_invoice = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end

      it 'returns nil when no customer id' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?customer_id=#{invoice.customer_id + 1}"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_nil
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

      it 'returns nil when no merchant id' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id + 1}"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_nil
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

      it 'returns nil when no status' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?status=2"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_nil
      end
    end

    context '?created_at=' do
      it 'returns the first invoice with that created_at'do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice['id']).to eq invoice.id

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end

      it 'returns nil when not valid created_at' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?created_at=2018-01-01 00:00:00"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice).to be_nil
      end
    end

    context '?updated_at=' do
      it 'returns the first invoice with that updated_at' do
        invoice = create(:invoice)

        get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

        raw_invoice = JSON.parse(response.body)

        expect(raw_invoice['id']).to eq invoice.id

        expect(response).to be_success
        expect(raw_invoice["id"]).to eq(invoice.id)
      end
    end

    it 'returns nil when not valid updated_at' do
      invoice = create(:invoice)

      get "/api/v1/invoices/find?updated_at=2018-01-01 00:00:00"

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice).to be_nil
    end
  end

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

      it 'returns returns empty when no primary key'
    end

    context '?customer_id=' do
      it 'returns all invoices with that customer_id' do
        invoices = create_list(:invoice, 2)

        get "/api/v1/invoices/find_all?customer_id=#{invoices.first.customer_id}"

        raw_invoices = JSON.parse(response.body)
        raw_invoice = raw_invoices.first

        expect(response).to be_success
        expect(raw_invoices.count).to be 2
        expect(raw_invoice["id"]).to eq(invoices.first.id)
      end
    end

    context '?merchant_id=' do
      it 'returns all invoices with that merchant_id' do
        invoices = create_list(:invoice, 3)

        get "/api/v1/invoices/find_all?merchant_id=#{invoices.first.merchant_id}"

        raw_invoices = JSON.parse(response.body)
        raw_invoice = raw_invoices.first

        expect(response).to be_success
        expect(raw_invoices.count).to be 3
        expect(raw_invoice["id"]).to eq(invoices.first.id)
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
    end
  end
end
