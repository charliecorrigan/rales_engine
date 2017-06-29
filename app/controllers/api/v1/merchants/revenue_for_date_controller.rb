class Api::V1::Merchants::RevenueForDateController < ApplicationController
  def show
    binding.pry
    @revenue = Merchant.revenue_for_date(revenue_for_date_params[:date])[0].total_revenue
  end

  private

    def revenue_for_date_params
      params.permit(:date)
    end
end
