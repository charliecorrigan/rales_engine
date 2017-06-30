class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  def index
    invoice = Invoice.find(params[:id])
    @invoice_items = invoice.invoice_items
    render 'api/v1/invoice_items/index'
  end
end