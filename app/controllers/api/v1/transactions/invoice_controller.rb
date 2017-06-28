class Api::V1::Transactions::InvoiceController < ApplicationController
  def show
    transaction = Transaction.find(params[:id])
    @invoice = transaction.invoice
  end
end
