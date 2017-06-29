class Api::V1::Items::MostItemsController < ApplicationController
  def index
    @items = Item.most_items(most_items_params[:quantity])
    render 'api/v1/items/index'
  end

  private

    def most_items_params
      params.permit(:quantity)
    end
end
