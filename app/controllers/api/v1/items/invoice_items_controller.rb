class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    item = Item.find(params[:id])
    @invoice_items = item.invoice_items
  end
end