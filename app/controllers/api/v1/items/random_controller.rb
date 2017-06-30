class Api::V1::Items::RandomController < ApplicationController
  def show
    @item = Item.order("RANDOM()").first
    render 'api/v1/items/show'
  end
end
