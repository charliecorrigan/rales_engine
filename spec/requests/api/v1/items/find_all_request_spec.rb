require 'rails_helper'

describe 'Items Find All API' do
  context 'GET /api/v1/items/find_all' do
    context '?id=' do
      it 'returns all items with that primary key' do
        item = create(:item)

        get "/api/v1/items/find_all?id=#{item.id}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 1
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns [] when no primary key' do

        get "/api/v1/items/find_all?id=1"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?name=' do
      it 'returns all items with that name' do
        items = create_list(:item, 2)

        get "/api/v1/items/find_all?name=#{items.first.name}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 2
        expect(raw_item["id"]).to eq(items.first.id)
      end

      it 'returns [] when no name found' do
        get "/api/v1/items/find_all?name=fake-name"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?description=' do
      it 'returns all items with that description' do
        items = create_list(:item, 2)

        get "/api/v1/items/find_all?description=#{items.first.description}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 2
        expect(raw_item["id"]).to eq(items.first.id)
      end

      it 'returns [] when no description found' do
        get "/api/v1/items/find_all?description=fake-description"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?unit_price=' do
      it 'returns all items with that unit_price' do
        items = create_list(:item, 2)

        get "/api/v1/items/find_all?unit_price=#{items.first.unit_price}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 2
        expect(raw_item["id"]).to eq(items.first.id)
      end

      it 'returns [] when no unit_price found' do
        get "/api/v1/items/find_all?unit_price=0"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?merchant_id=' do
      it 'returns all items with that merchant_id' do
        merchant = create(:merchant)
        items = create_list(:item, 3, merchant: merchant)

        get "/api/v1/items/find_all?merchant_id=#{items.first.merchant_id}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 3
        expect(raw_item["id"]).to eq(items.first.id)
      end

      it 'returns [] when no merchant_id found' do

        get "/api/v1/items/find_all?merchant_id=1"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?created_at=' do
      it 'returns all items with that created_at' do
        item = create(:item)
        create(:item)
        create(:item)
        create(:item, created_at: "2013-03-09 08:57:21")

        get "/api/v1/items/find_all?created_at=#{item.created_at}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 3
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns [] when no created_at found' do

        get "/api/v1/items/find_all?created_at=2013-03-09 08:57:21"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end

    context '?updated_at=' do
      it 'returns all items with that updated_at' do
        item = create(:item)
        create(:item)
        create(:item)
        create(:item, updated_at: "2013-03-09 08:57:21")

        get "/api/v1/items/find_all?updated_at=#{item.updated_at}"

        raw_items = JSON.parse(response.body)
        raw_item = raw_items.first

        expect(response).to be_success
        expect(raw_items.count).to be 3
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns [] when no updated_at found' do

        get "/api/v1/items/find_all?updated_at=2013-03-09 08:57:21"

        raw_item = JSON.parse(response.body)

        expect(raw_item).to be_a Array
        expect(raw_item.length).to eq 0
      end
    end
  end
end
