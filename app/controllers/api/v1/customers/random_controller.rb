class Api::V1::Customers::RandomController < ApplicationController
  def show
    @customer = Customer.order("RANDOM()").first
    render 'api/v1/customers/show'
  end
end