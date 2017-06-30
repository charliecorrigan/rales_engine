class Api::V1::Merchants::RandomController < ApplicationController
  def show
    @merchant = Merchant.order("RANDOM()").first
    render 'api/v1/merchants/show'
  end
end