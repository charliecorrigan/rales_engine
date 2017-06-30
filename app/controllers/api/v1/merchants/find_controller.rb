class Api::V1::Merchants::FindController < ApplicationController
  def index
    @merchants =  Merchant.where(find_merchant_params)
    render 'api/v1/merchants/index'
  end

  def show
    @merchant = Merchant.find_by(find_merchant_params)
    render :json => { :error => 'not found' }, :status => 422 if @merchant.nil?
    render 'api/v1/merchants/show' if @merchant
  end

  private
    def find_merchant_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end