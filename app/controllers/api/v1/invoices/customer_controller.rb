class Api::V1::Invoices::CustomerController < ApplicationController
  def show
    invoice = Invoice.find(params[:id])
    @customer = invoice.customer
  end
end
