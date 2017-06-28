class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  def index
    merchant_id = params[:id]
    @customers = Merchant.select('customers.*')
                         .joins(:invoices)
                         .joins(:transactions)
                         .joins(:customers)
                         .where('merchant.id = ?', merchant_id)
                         .where.not(result:'failed')
  end
end
