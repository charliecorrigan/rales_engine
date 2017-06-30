class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    invoice = Invoice.find(params[:id])
    @transactions = invoice.transactions
    render 'api/v1/transactions/index'
  end
end