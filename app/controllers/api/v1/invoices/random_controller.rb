class Api::V1::Invoices::RandomController < ApplicationController
  def show
    @invoice = Invoice.order("RANDOM()").first
    render 'api/v1/invoices/index'
  end
end
