class Api::V1::Merchants::RevenueForDateController < ApplicationController
  def show
    @revenue = Merchant.revenue_for_date(revenue_for_date_params[:date])
  end

  private

    def revenue_for_date_params
      params.permit(:date)
    end
end
