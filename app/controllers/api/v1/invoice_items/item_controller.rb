class Api::V1::InvoiceItems::ItemController < ApplicationController
  def show
    invoice_item = InvoiceItem.find(params[:id])
    @item = invoice_item.item
    render 'api/v1/items/show'
  end
end