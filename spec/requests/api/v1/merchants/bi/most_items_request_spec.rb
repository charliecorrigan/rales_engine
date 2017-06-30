require 'rails_helper'

describe "Merchants Most Items API" do
  context 'GET /api/v1/merchants/most_items?quantity=x' do
    it "sends the top x merchants ranked by total number of items sold" do
      merchants = create_list(:merchant, 4)

      merchants.each.with_index do |merchant, idx|
        invoice = create(:invoice, :with_transactions, merchant: merchant)
        create_list(:invoice_item, idx + 1, invoice: invoice)
      end

      get "/api/v1/merchants/most_items?quantity=2"

      expect(response).to be_success

      result = JSON.parse(response.body)
      merchant_ids = result.map do |merchant|
        merchant["id"]
      end

      expect(result).to be_a Array
      expect(result.length).to eq(2)
      expect(merchant_ids.include?(merchants[2].id)).to be true
      expect(merchant_ids.include?(merchants[3].id)).to be true
      expect(merchant_ids.include?(merchants[0].id)).to be false
      expect(merchant_ids.include?(merchants[1].id)).to be false
    end
  end
end
