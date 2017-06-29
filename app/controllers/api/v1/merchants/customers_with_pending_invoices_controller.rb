class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    @customers = merchant.customers_with_pending_invoices
    render 'api/v1/customers/index'
  end
end
