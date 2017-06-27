require 'rails_helper'

describe 'Invoices API' do
  context 'GET /api/v1/invoices' do
    it 'sends a list of all invoices' do

    end
    it 'does not respond to /v2/'
  end

  context 'GET /api/v1/invoices/:id' do
    it 'sends the information about one invoice'

  end

  context 'GET /api/v1/invoices/find' do
    context '?id=' do
      it 'returns the invoice with that primary key'
      it 'returns returns empty when no primary key'
    end
    context '?customer_id=' do
      it 'returns the first invoice with that customer_id'
    end
    context '?merchant_id=' do
      it 'returns the first invoice with that merchant_id'
    end
    context '?status=' do
      it 'returns the first invoice with that status'
    end
    context '?created_at=' do
      it 'returns the first invoice with that created_at'
    end
    context '?updated_at=' do
      it 'returns the first invoice with that updated_at'
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
