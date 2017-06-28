class Api::V1::Transactions::FindController < ApplicationController
  def index
    @transactions = Transaction.where(find_transaction_params)
  end

  def show
    render json: Transaction.find_by(find_transaction_params)
  end

  private
    def find_transaction_params
      params.permit(:id, :credit_card_number, :result, :created_at, :updated_at, :invoice_id)
    end
end