class Api::V1::InvoiceItems::ItemController < ApplicationController
  def show
    invoice_item = InvoiceItem.find(params[:id])
    @item = invoice_item.item
  end
end