class Api::V1::InvoiceItems::FindController < ApplicationController
  include Centable

  def index
    @invoice_items = InvoiceItem.where(find_invoice_item_params)
    render 'api/v1/invoice_items/index'
  end

  def show
    @invoice_item = InvoiceItem.find_by(find_invoice_item_params)
    render :json => { :error => 'not found' }, :status => 422 if @invoice_item.nil?
    render 'api/v1/invoice_items/show' if @invoice_item
  end

  private

    def find_invoice_item_params
      params.permit(:id, :invoice_id, :item_id, :quantity, :created_at, :updated_at).merge(unit_price)
    end
end
