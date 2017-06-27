class Api::V1::Invoices::FindController < ApplicationController
  def show
    render json: Invoice.find_by(find_invoice_params)
  end

  private
    def find_invoice_params
      params.permit(:id, :customer_id, :status, :created_at, :updated_at)
    end
end
