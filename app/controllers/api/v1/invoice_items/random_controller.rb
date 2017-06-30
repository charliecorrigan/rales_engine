class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    @invoice_item = InvoiceItem.order("RANDOM()").first
    render 'api/v1/invoice_items/show'
  end
end
