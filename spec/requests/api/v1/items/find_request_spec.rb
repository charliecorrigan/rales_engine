require 'rails_helper'

describe 'Items Find API' do
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
      it 'returns the first item with that merchant_id' do
        item = create(:item)

        get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

        raw_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns error when no matching merchant id' do
        item = create(:item)

        get "/api/v1/items/find?merchant_id=#{item.merchant_id + 1}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?created_at=' do
      it 'returns the first item with that created_at'do
        item = create(:item)

        get "/api/v1/items/find?created_at=#{item.created_at}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['id']).to eq item.id

        expect(response).to be_success
        expect(raw_item["id"]).to eq(item.id)
      end

      it 'returns error when not valid created_at' do
        item = create(:item)

        get "/api/v1/items/find?created_at=2018-01-01 00:00:00"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

    context '?updated_at=' do
      it 'returns the first item with that updated_at' do
        item = create(:item)

        get "/api/v1/items/find?updated_at=#{item.updated_at}"

        raw_item = JSON.parse(response.body)

        expect(raw_item['id']).to eq item.id

        expect(response).to be_success
        expect(raw_item["id"]).to eq(item.id)
      end
      
      it 'returns error when not valid updated_at' do
        item = create(:item)

        get "/api/v1/items/find?updated_at=2018-01-01 00:00:00"

        raw_item = JSON.parse(response.body)

        expect(raw_item['error']).to eq 'not found'
      end
    end

  end
end
