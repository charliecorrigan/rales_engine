class Api::V1::Items::FindController < ApplicationController
  include Centable

  def index
    @items = Item.where(find_item_params)
  end

  def show
    @item = Item.find_by(find_item_params)
    render :json => { :error => 'not found' }, :status => 422 if @item.nil?
    @item
  end

  private

    def find_item_params
      params.permit(:id, :name, :description, :merchant_id, :created_at, :updated_at).merge(unit_price)
    end
end
