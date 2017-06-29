class Api::V1::Items::MostItemsController < ApplicationController
  def index
    @items = Item.most_items(most_items_params[:quantity])
  end

  private

    def most_items_params
      params.permit(:quantity)
    end
end
