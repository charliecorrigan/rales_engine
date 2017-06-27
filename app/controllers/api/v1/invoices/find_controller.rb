module Api
  module V1
    module Invoices
      class FindController < ApplicationController
        def index
          render json: Invoice.where(find_invoice_params)
        end
        def show
          render json: Invoice.find_by(find_invoice_params)
        end

        private
          def find_invoice_params
            params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
          end
      end
    end
  end
end
