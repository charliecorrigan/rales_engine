class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    customer = Customer.find(params[:id])
    @transactions = customer.transactions
    render 'api/v1/transactions/index'
  end
end
