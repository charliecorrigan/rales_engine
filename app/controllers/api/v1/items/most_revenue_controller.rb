class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    @items = Item.most_revenue(most_revenue_params[:quantity])
    render 'api/v1/items/index'
  end

  private

    def most_revenue_params
      params.permit(:quantity)
    end
end
