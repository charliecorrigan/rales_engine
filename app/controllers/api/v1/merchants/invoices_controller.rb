class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    @invoices = merchant.invoices
    render 'api/v1/invoices/index'
  end
end
