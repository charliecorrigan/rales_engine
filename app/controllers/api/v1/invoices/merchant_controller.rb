class Api::V1::Invoices::MerchantController < ApplicationController
  def show
    invoice = Invoice.find(params[:id])
    @merchant = invoice.merchant
  end
end