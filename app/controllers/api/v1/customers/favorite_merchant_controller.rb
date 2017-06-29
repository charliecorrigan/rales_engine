class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    customer = Customer.find(params[:id])
    @merchant = customer.favorite_merchant
  end
end