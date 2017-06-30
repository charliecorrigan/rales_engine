class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    item = Item.find(params[:id])
    @invoice_items = item.invoice_items
    render 'api/v1/invoice_items/index'
  end
end