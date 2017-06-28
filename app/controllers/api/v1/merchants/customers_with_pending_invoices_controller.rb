class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  def index
    merchant_id = params[:id]
    @customers = Customer.select("customers.*").joins(:invoices).joins(:transactions).where("invoices.merchant_id = ?", merchant_id).where.not("transactions.result = ?", 'failed')
    # @customers = Merchant.select("customers.*").joins(:invoices).joins(:customers).where('invoices.merchant_id = ?', merchant_id)
                        #
                        #  .group(:customer_id)
  end
end
