class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    invoice = Invoice.find(params[:id])
    @items = invoice.items
  end
end