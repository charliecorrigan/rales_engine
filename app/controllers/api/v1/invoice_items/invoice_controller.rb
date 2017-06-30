class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  def show
    invoice_item = InvoiceItem.find(params[:id])
    @invoice = invoice_item.invoice
    render 'api/v1/invoices/show'
  end
end