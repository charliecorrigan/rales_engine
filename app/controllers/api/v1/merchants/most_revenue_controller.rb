class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    @merchants = Merchant.most_revenue(most_revenue_params[:quantity])
  end

  private

    def most_revenue_params
      params.permit(:quantity)
    end
end
