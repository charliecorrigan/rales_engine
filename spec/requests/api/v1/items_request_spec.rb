require 'rails_helper'

describe 'Items API' do
  context 'GET /api/v1/items' do
    it 'sends a list of all items' do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first

      expect(raw_items.count).to be 3

      expect(raw_item).to have_key('name')
      expect(raw_item['name']).to be_a String

      expect(raw_item).to have_key('description')
      expect(raw_item['description']).to be_a String

      expect(raw_item).to have_key('unit_price')
      expect(raw_item['unit_price']).to be_a Integer

      expect(raw_item).to have_key('merchant_id')
      expect(raw_item['merchant_id']).to be_a Integer

      expect(raw_item).to have_key('created_at')
      expect(raw_item['created_at']).to be_a String
      expect(raw_item).to have_key('updated_at')
      expect(raw_item['updated_at']).to be_a String
    end

    it 'does not respond to /v2/'
  end

  context 'GET /api/v1/items/:id' do
    it 'sends the information about one item' do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      raw_item = JSON.parse(response.body)

      expect(raw_item['id']).to eq item.id
      expect(raw_item).to have_key('name')
      expect(raw_item['name']).to be_a String

      expect(raw_item).to have_key('description')
      expect(raw_item['description']).to be_a String

      expect(raw_item).to have_key('unit_price')
      expect(raw_item['unit_price']).to be_a Integer

      expect(raw_item).to have_key('merchant_id')
      expect(raw_item['merchant_id']).to be_a Integer

      expect(raw_item).to have_key('created_at')
      expect(raw_item['created_at']).to be_a String
      expect(raw_item).to have_key('updated_at')
      expect(raw_item['updated_at']).to be_a String
    end
  end

  context 'GET /api/v1/items/find' do
    context '?id=' do
      it 'returns the item with that primary key' do
        item = create(:item)

        get "/api/v1/items/find?id=#{item.id}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns error when no matching primary key' do
        item = create(:item)

        get "/api/v1/items/find?id=#{item.id + 1}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?name=' do
      it 'returns the item with that name' do
        item = create(:item)

        get "/api/v1/items/find?name=#{item.name}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns error when no matching name' do
        item = create(:item)

        get "/api/v1/items/find?name=fake name"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?description=' do
      it 'returns the item with that description' do
        item = create(:item)

        get "/api/v1/items/find?description=#{item.description}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns error when no matching description' do
        item = create(:item)

        get "/api/v1/items/find?description=fake desc"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?unit_price=' do
      it 'returns the item with that unit_price' do
        item = create(:item)

        get "/api/v1/items/find?unit_price=#{item.unit_price}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns error when no matching unit_price' do
        item = create(:item)

        get "/api/v1/items/find?unit_price=#{item.unit_price + 1}"

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

      it 'returns error when no matching merchant id' do
        invoice = create(:item)

        get "/api/v1/items/find?merchant_id=#{invoice.merchant_id + 1}"

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

      it 'returns error when not valid created_at' do
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

    it 'returns error when not valid updated_at' do
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
