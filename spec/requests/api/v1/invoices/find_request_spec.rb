require 'rails_helper'

describe 'Invoices Find API' do
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

        expect(raw_invoice['error']).to eq 'not found'
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

        expect(raw_invoice['error']).to eq 'not found'
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

        expect(raw_invoice['error']).to eq 'not found'
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

        expect(raw_invoice['error']).to eq 'not found'
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

        expect(raw_invoice['error']).to eq 'not found'
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

      expect(raw_invoice['error']).to eq 'not found'
    end
  end
end
