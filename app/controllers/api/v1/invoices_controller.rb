<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> skip failing date search spec
module Api
  module V1
    class InvoicesController < ApplicationController
      def index
<<<<<<< HEAD
        @invoices = Invoice.all
      end

      def show
        @invoice = Invoice.find(params[:id])
      end
    end
=======
class Api::V1::InvoicesController < ApplicationController
  def index
    render json: Invoice.all
>>>>>>> complete invoices index response endpoint
  end
=======
        render json: Invoice.all
      end
>>>>>>> skip failing date search spec

      def show
        render json: Invoice.find(params[:id])
      end
    end
  end
end
