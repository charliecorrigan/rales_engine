class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    @merchants = Merchant.find_by_most_items(most_items_params[:quantity])
    render 'api/v1/merchants/index'
  end

  private

  def most_items_params
    params.permit(:quantity)
  end
end