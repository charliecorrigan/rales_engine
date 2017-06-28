class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    @revenue = Merchant.revenue(params[:id])
  end
end
