class Api::V1::Items::FindController < ApplicationController
  def index
    @item = Item.find_by(find_item_params)
    render :json => { :error => 'not found' }, :status => 422 if @item.nil?
    @item
  end

  def show
    @item = Item.find_by(find_item_params)
    render :json => { :error => 'not found' }, :status => 422 if @item.nil?
    @item
  end

  private

    def find_item_params
      params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    end
end
