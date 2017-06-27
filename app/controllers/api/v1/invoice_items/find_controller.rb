class Api::V1::InvoiceItems::FindController < ApplicationController
  def index
    @invoice_items = InvoiceItem.where(find_invoice_item_params)
  end

  def show
    @invoice_item = InvoiceItem.find_by(find_invoice_item_params)
    render :json => { :error => 'not found' }, :status => 422 if @invoice_item.nil?
    @invoice_item
  end

  private

    def find_invoice_item_params
      params.permit(:id, :invoice_id, :item_id, :unit_price, :quantity, :created_at, :updated_at)
    end
end
