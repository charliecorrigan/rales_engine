class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    @items = Item.most_revenue(most_revenue_params[:quantity])
  end

  private

    def most_revenue_params
      params.permit(:quantity)
    end
end
