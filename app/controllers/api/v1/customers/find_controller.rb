class Api::V1::Customers::FindController < ApplicationController
  def index
    render json: Customer.where(find_customer_params)
  end

  private
    def find_customer_params
      params.permit(:id, :last_name, :first_name, :created_at, :updated_at)
    end
end
