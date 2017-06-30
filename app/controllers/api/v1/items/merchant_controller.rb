class Api::V1::Items::MerchantController < ApplicationController
  def show
    item = Item.find(params[:id])
    @merchant = item.merchant
    render 'api/v1/merchants/show'
  end
end