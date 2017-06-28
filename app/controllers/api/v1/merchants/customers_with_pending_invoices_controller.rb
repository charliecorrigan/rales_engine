class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  def index
    merchant_id = params[:id]
    @customers = Merchant.customers_with_pending_invoices(merchant_id)
  end
end
