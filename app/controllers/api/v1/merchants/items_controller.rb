class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    @items = merchant.items
    render 'api/v1/items/index'
  end
end
