require 'rails_helper'

describe 'Items API' do
  context 'GET /api/v1/items' do
    it 'sends a list of all invoices' do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first

      expect(raw_items.count).to be 3

      expect(raw_item).to have_key('name')
      expect(raw_item['name']).to be_a String

      expect(raw_item).to have_key('unit_price')
      expect(raw_item['unit_price']).to be_a Integer

      expect(raw_item).to have_key('description')
      expect(raw_item['description']).to be_a String

      expect(raw_item).to have_key('merchant_id')
      expect(raw_item['merchant_id']).to be_a Integer

      expect(raw_item).to have_key('created_at')
      expect(raw_item['created_at']).to be_a String
      expect(raw_item).to have_key('updated_at')
      expect(raw_item['updated_at']).to be_a String
    end

    it 'does not respond to /v2/'
  end

  xcontext 'GET /api/v1/items/:id' do
    it 'sends the information about one invoice' do
      invoice = create(:item)

      get "/api/v1/items/#{invoice.id}"

      raw_item = JSON.parse(response.body)

      expect(raw_item['id']).to eq invoice.id
      expect(raw_item).to have_key('customer_id')
      expect(raw_item['customer_id']).to be_a Integer
      expect(raw_item['customer_id']).to eq invoice.customer_id
      expect(raw_item).to have_key('merchant_id')
      expect(raw_item['merchant_id']).to be_a Integer
      expect(raw_item['merchant_id']).to eq invoice.merchant_id
      expect(raw_item).to have_key('status')
      expect(raw_item['status']).to be_a String
      expect(raw_item['status']).to eq invoice.status
      expect(raw_item).to have_key('created_at')
      expect(raw_item['created_at']).to be_a String
      expect(raw_item['created_at']).to eq invoice.created_at
      expect(raw_item).to have_key('updated_at')
      expect(raw_item['updated_at']).to be_a String
      expect(raw_item['updated_at']).to eq invoice.updated_at
    end
  end

  xcontext 'GET /api/v1/items/find' do
    context '?id=' do
      it 'returns the invoice with that primary key' do
        invoice = create(:item)

        get "/api/v1/items/find?id=#{invoice.id}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(invoice.id)
      end

      it 'returns nil when no primary key' do
        invoice = create(:item)

        get "/api/v1/items/find?id=#{invoice.id + 1}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?customer_id=' do
      it 'returns the first invoice with that customer_id' do
        invoice = create(:item)

        get "/api/v1/items/find?customer_id=#{invoice.customer_id}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(invoice.id)
      end

      it 'returns nil when no customer id' do
        invoice = create(:item)

        get "/api/v1/items/find?customer_id=#{invoice.customer_id + 1}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?merchant_id=' do
      it 'returns the first invoice with that merchant_id' do
        invoice = create(:item)

        get "/api/v1/items/find?merchant_id=#{invoice.merchant_id}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(invoice.id)
      end

      it 'returns nil when no merchant id' do
        invoice = create(:item)

        get "/api/v1/items/find?merchant_id=#{invoice.merchant_id + 1}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?status=' do
      it 'returns the first invoice with that status' do
        invoice = create(:item)

        get "/api/v1/items/find?status=#{invoice.status}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(invoice.id)
      end

      it 'returns nil when no status' do
        invoice = create(:item)

        get "/api/v1/items/find?status=2"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?created_at=' do
      it 'returns the first invoice with that created_at'do
        invoice = create(:item)

        get "/api/v1/items/find?created_at=#{invoice.created_at}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['id']).to eq invoice.id

        expect(response).to be_success
        expect(raw_item["id"]).to eq(invoice.id)
      end

      it 'returns nil when not valid created_at' do
        invoice = create(:item)

        get "/api/v1/items/find?created_at=2018-01-01 00:00:00"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?updated_at=' do
      it 'returns the first invoice with that updated_at' do
        invoice = create(:item)

        get "/api/v1/items/find?updated_at=#{invoice.updated_at}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['id']).to eq invoice.id

        expect(response).to be_success
        expect(raw_item["id"]).to eq(invoice.id)
      end
    end

    it 'returns nil when not valid updated_at' do
      invoice = create(:item)

      get "/api/v1/items/find?updated_at=2018-01-01 00:00:00"

      raw_item = JSON.parse(response.body)

      expect(raw_item['error']).to eq 'not found'
    end
  end

  xcontext 'GET /api/v1/items/find_all' do
    context '?id=' do
      it 'returns all invoices with that primary key' do
        invoice = create(:item)

        get "/api/v1/items/find_all?id=#{invoice.id}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 1
        expect(raw_item["id"]).to eq(invoice.id)
      end

      it 'returns [] when no primary key' do

        get "/api/v1/items/find_all?id=1"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?customer_id=' do
      it 'returns all invoices with that customer_id' do
        invoices = create_list(:item, 2)

        get "/api/v1/items/find_all?customer_id=#{invoices.first.customer_id}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 2
        expect(raw_item["id"]).to eq(invoices.first.id)
      end

      it 'returns [] when no customer_id found' do

        get "/api/v1/items/find_all?customer_id=1"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?merchant_id=' do
      it 'returns all invoices with that merchant_id' do
        invoices = create_list(:item, 3)

        get "/api/v1/items/find_all?merchant_id=#{invoices.first.merchant_id}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 3
        expect(raw_item["id"]).to eq(invoices.first.id)
      end

      it 'returns [] when no merchant_id found' do

        get "/api/v1/items/find_all?merchant_id=1"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?status=' do
      it 'returns all invoices with that status' do
        invoices = create_list(:item, 2)

        get "/api/v1/items/find_all?status=#{invoices.first.status}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 2
        expect(raw_item["id"]).to eq(invoices.first.id)
      end

      it 'returns [] when no status found' do

        get "/api/v1/items/find_all?status=1"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?created_at=' do
      it 'returns all invoices with that created_at' do
        invoice = create(:item)
        create(:item)
        create(:item)
        create(:item, created_at: "2013-03-09 08:57:21")

        get "/api/v1/items/find_all?created_at=#{invoice.created_at}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 3
        expect(raw_item["id"]).to eq(invoice.id)
      end

      it 'returns [] when no created_at found' do

        get "/api/v1/items/find_all?created_at=2013-03-09 08:57:21"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?updated_at=' do
      it 'returns all invoices with that updated_at' do
        invoice = create(:item)
        create(:item)
        create(:item)
        create(:item, updated_at: "2013-03-09 08:57:21")

        get "/api/v1/items/find_all?updated_at=#{invoice.updated_at}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 3
        expect(raw_item["id"]).to eq(invoice.id)
      end

      it 'returns [] when no updated_at found' do

        get "/api/v1/items/find_all?updated_at=2013-03-09 08:57:21"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end
  end

  xcontext 'GET /api/v1/invoice/random' do
    it 'returns a random invoice' do
      invoices = create_list(:item, 3)
      ids = invoices.map(&:id)

      get "/api/v1/items/random"

      raw_item = JSON.parse(response.body)

      expect(ids.include?(raw_item['id'])).to be true
    end
  end
end
