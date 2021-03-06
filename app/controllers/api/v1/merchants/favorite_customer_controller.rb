class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    @customer = merchant.favorite_customer
    render 'api/v1/customers/show'
  end
end
