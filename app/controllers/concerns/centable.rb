module Centable
  extend ActiveSupport::Concern

  def unit_price
    price = {}
    price = {unit_price: convert_to_cents} if params[:unit_price]
    price
  end

  private
    def convert_to_cents
      params[:unit_price].gsub('.','').to_i
    end
end
