require 'rails_helper'

describe 'Invoice Items Find All API' do
  context 'GET /api/v1/invoice_items/find_all' do
    context '?id=' do
      it 'returns all invoice_items with that primary key' do
        invoice_item = create(:invoice_item)

        get "/api/v1/invoice_items/find_all?id=#{invoice_item.id}"

        raw_invoice_items = JSON.parse(response.body)
        raw_invoice_item = raw_invoice_items.first

        expect(response).to be_success
        expect(raw_invoice_items.count).to be 1
        expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      end

      it 'returns [] when no primary key' do

        get "/api/v1/invoice_items/find_all?id=1"

        raw_invoice_item = JSON.parse(response.body)

        expect(raw_invoice_item).to be_a Array
        expect(raw_invoice_item.length).to eq 0
      end
    end

    context '?invoice_id=' do
      it 'returns all invoice_items with that invoice_id' do
        invoice = create(:invoice)
        invoice_items = create_list(:invoice_item, 2, invoice: invoice)

        get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_items.first.invoice_id}"

        raw_invoice_items = JSON.parse(response.body)
        raw_invoice_item = raw_invoice_items.first

        expect(response).to be_success
        expect(raw_invoice_items.count).to be 2
        expect(raw_invoice_item["id"]).to eq(invoice_items.first.id)
      end

      it 'returns [] when no invoice_id found' do
        invoice = create(:invoice)
        invoice_items = create_list(:invoice_item, 2, invoice: invoice)

        get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_items.first.invoice_id + 1}"

        raw_invoice_item = JSON.parse(response.body)

        expect(raw_invoice_item).to be_a Array
        expect(raw_invoice_item.length).to eq 0
      end
    end

    context '?item_id=' do
      it 'returns all invoice_items with that item_id' do
        item = create(:item)
        invoice_items = create_list(:invoice_item, 2, item: item)

        get "/api/v1/invoice_items/find_all?item_id=#{invoice_items.first.item_id}"

        raw_invoice_items = JSON.parse(response.body)
        raw_invoice_item = raw_invoice_items.first

        expect(response).to be_success
        expect(raw_invoice_items.count).to be 2
        expect(raw_invoice_item["id"]).to eq(invoice_items.first.id)
      end

      it 'returns [] when no item_id found' do
        item = create(:item)
        invoice_items = create_list(:invoice_item, 2, item: item)

        get "/api/v1/invoice_items/find_all?item_id=#{invoice_items.first.item_id + 1}"

        raw_invoice_item = JSON.parse(response.body)

        expect(raw_invoice_item).to be_a Array
        expect(raw_invoice_item.length).to eq 0
      end
    end

    context '?unit_price=' do
      it 'returns all invoice_items with that unit_price' do
        invoice_items = create_list(:invoice_item, 2)

        get "/api/v1/invoice_items/find_all?unit_price=#{invoice_items.first.unit_price}"

        raw_invoice_items = JSON.parse(response.body)
        raw_invoice_item = raw_invoice_items.first

        expect(response).to be_success
        expect(raw_invoice_items.count).to be 2
        expect(raw_invoice_item["id"]).to eq(invoice_items.first.id)
      end

      it 'returns [] when no unit_price found' do
        get "/api/v1/invoice_items/find_all?unit_price=0"

        raw_invoice_item = JSON.parse(response.body)

        expect(raw_invoice_item).to be_a Array
        expect(raw_invoice_item.length).to eq 0
      end
    end

    context '?quantity=' do
      it 'returns all invoice_items with that quantity' do
        invoice_items = create_list(:invoice_item, 2)

        get "/api/v1/invoice_items/find_all?quantity=#{invoice_items.first.quantity}"

        raw_invoice_items = JSON.parse(response.body)
        raw_invoice_item = raw_invoice_items.first

        expect(response).to be_success
        expect(raw_invoice_items.count).to be 2
        expect(raw_invoice_item["id"]).to eq(invoice_items.first.id)
      end

      it 'returns [] when no quantity found' do
        get "/api/v1/invoice_items/find_all?quantity=0"

        raw_invoice_item = JSON.parse(response.body)

        expect(raw_invoice_item).to be_a Array
        expect(raw_invoice_item.length).to eq 0
      end
    end

    context '?created_at=' do
      it 'returns all invoice_items with that created_at' do
        invoice_item = create(:invoice_item)
        create(:invoice_item)
        create(:invoice_item)
        create(:invoice_item, created_at: "2013-03-09 08:57:21")

        get "/api/v1/invoice_items/find_all?created_at=#{invoice_item.created_at}"

        raw_invoice_items = JSON.parse(response.body)
        raw_invoice_item = raw_invoice_items.first

        expect(response).to be_success
        expect(raw_invoice_items.count).to be 3
        expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      end

      it 'returns [] when no created_at found' do

        get "/api/v1/invoice_items/find_all?created_at=2013-03-09 08:57:21"

        raw_invoice_item = JSON.parse(response.body)

        expect(raw_invoice_item).to be_a Array
        expect(raw_invoice_item.length).to eq 0
      end
    end

    context '?updated_at=' do
      it 'returns all invoice_items with that updated_at' do
        invoice_item = create(:invoice_item)
        create(:invoice_item)
        create(:invoice_item)
        create(:invoice_item, updated_at: "2013-03-09 08:57:21")

        get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item.updated_at}"

        raw_invoice_items = JSON.parse(response.body)
        raw_invoice_item = raw_invoice_items.first

        expect(response).to be_success
        expect(raw_invoice_items.count).to be 3
        expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      end

      it 'returns [] when no updated_at found' do

        get "/api/v1/invoice_items/find_all?updated_at=2013-03-09 08:57:21"

        raw_invoice_item = JSON.parse(response.body)

        expect(raw_invoice_item).to be_a Array
        expect(raw_invoice_item.length).to eq 0
      end
    end
  end
end
