module Api
  module V1
    module Invoices
      class FindController < ApplicationController
        def index
          @invoices = Invoice.where(find_invoice_params)
        end

        def show
          @invoice = Invoice.find_by(find_invoice_params)
          render :json => { :error => 'not found' }, :status => 422 if @invoice.nil?
          @invoice
        end

        private
          def find_invoice_params
            params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
          end
      end
    end
  end
end
