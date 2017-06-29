require 'rails_helper'

describe "Merchants Most Items API" do
  context 'GET /api/v1/merchants/most_items?quantity=x' do
    it "sends the top x merchants ranked by total number of items sold" do
      merchants = create_list(:merchant, 4)
      invoice1 = create(:invoice, merchant: merchants[0])
      invoice2 = create(:invoice, merchant: merchants[1])
      invoice3 = create(:invoice, merchant: merchants[2])
      invoice4 = create(:invoice, merchant: merchants[3])
      create(:invoice_item, invoice: invoice1)
      create(:invoice_item, invoice: invoice1)
      create(:invoice_item, invoice: invoice2)
      create(:invoice_item, invoice: invoice2)
      create(:invoice_item, invoice: invoice2)
      create(:invoice_item, invoice: invoice2)
      create(:invoice_item, invoice: invoice3)
      create(:invoice_item, invoice: invoice3)
      create(:invoice_item, invoice: invoice3)
      create(:invoice_item, invoice: invoice4)
      create(:transaction, invoice: invoice1)
      create(:transaction, invoice: invoice2)
      create(:transaction, invoice: invoice3)
      create(:transaction, invoice: invoice4)

      get "/api/v1/merchants/most_items?quantity=2"

      expect(response).to be_success

      result = JSON.parse(response.body)
      merchant_ids = result.map do |merchant|
        merchant["id"]
      end

      expect(result).to be_a Array
      expect(result.length).to eq(2)
      expect(merchant_ids.include?(merchants[1].id)).to be true
      expect(merchant_ids.include?(merchants[2].id)).to be true
      expect(merchant_ids.include?(merchants[0].id)).to be false
      expect(merchant_ids.include?(merchants[3].id)).to be false
    end
  end
end