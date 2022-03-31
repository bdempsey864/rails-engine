class Api::V1::MerchantsSearchController < ApplicationController
  def find
    merchant = Merchant.search_name(params[:name])
    if merchant != nil 
      render json: MerchantSerializer.new(merchant)
    else
      render json: { data: { errors: 'no name matched fragment' } }, status: 200
    end
  end
end