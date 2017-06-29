class Api::V1::InvoiceItemsController < ApplicationController
  def index
    @invoice_items = InvoiceItem.all
  end

  def show
    @invoice_item = InvoiceItem.find(params[:id])
  end
end
