class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  def index
    @customers = Merchant.customers_with_pending_invoices(params[:id])
    render 'api/v1/customers/index'
  end
end
