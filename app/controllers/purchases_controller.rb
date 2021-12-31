require 'square'

class PurchasesController < ApplicationController
  before_action :initialize_session

  def purchase 
    session[:cart] = purchase_params
    if session[:cart]
      render json: {message: "success", cart: session[:cart]}
    else 
      render json: {message: "something went wrong"}
    end
  end

  def call_square_api
    product_name_string = "Product: #{session[:cart][:category]}, Scent: #{session[:cart][:scent]}"

    if session[:cart][:color]
      product_name_string += ",Color: #{session[:cart][:color]}"
    end
    if session[:cart][:bodyButterWeight]
      product_name_string += ", Weight: #{session[:cart][:bodyButterWeight]}"
    end
    if session[:cart][:bodyButterPrice]
      product_name_string += ", Price: #{session[:cart][:bodyButterPrice]}"
    end
    if session[:cart][:price]
      product_name_string += ", Price: #{session[:cart][:price]}"
    end

    # Create an instance of the API Client and initialize it with the credentials 
    # for the Square account whose assets you want to manage.
    client = Square::Client.new(
      access_token: 'YOUR SANDBOX ACCESS TOKEN HERE',
      environment: 'sandbox'
    )

    

  end

  private

  def purchase_params
    params.require(:purchase).permit(:category, :scent, :color, :bodyButterWeight, :bodyButterPrice, :price, :addressLine1, :addressLine2, :city, :state, :postalCode)
  end

  def initialize_session
    session[:cart] ||= []
  end
end
