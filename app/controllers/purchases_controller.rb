require 'square'
require 'securerandom'

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
      api_call_item_base_price = session[:cart][:bodyButterPrice].to_i * 100
    end
    if session[:cart][:price]
      product_name_string += ", Price: #{session[:cart][:price]}"
      api_call_item_base_price = session[:cart][:price].to_i * 100
    end

    tax = api_call_item_base_price * 0.1040

    # Create an instance of the API Client and initialize it with the credentials 
    # for the Square account whose assets you want to manage.
    client = Square::Client.new(
      access_token: ENV["SANDBOX_ACCESS_TOKEN"],
      environment: 'sandbox'
    )

    result = client.checkout.create_checkout(
      location_id: ENV["SANDBOX_LOCATION_ID"],
      body: {
        idempotency_key: SecureRandom.uuid,
        order: {
          order: {
            location_id: ENV["SANDBOX_LOCATION_ID"],
            line_items: [
              {
                name: ,
                quantity: "1",
                base_price_money: {
                  amount: api_call_item_base_price,
                  currency: "USD"
                }
              }
            ],
            taxes: [
              {
                name: "Sales Tax",
                percentage: "10.4",
                applied_money: {
                  amount: tax,
                  currency: "USD"
                },
                scope: "ORDER"
              }
            ],
            fulfillments: [
              {
                type: "SHIPMENT",
                shipment_details: {
                  recipient: {
                    display_name: purchase_params[:customerName],
                    address: {
                      address_line_1: "8118 61st Ave NW",
                      address_line_2: "123",
                      locality: "Gig Harbor",
                      administrative_district_level_1: "Washington",
                      postal_code: "98332",
                      country: "US"
                    }
                  }
                }
              }
            ]
          },
          idempotency_key: "b9b65019-ecf9-4d83-a3bc-49b86f81a862"
        },
        merchant_support_email: "mistybeasley@beasleyscents.com"
      }
    )

    if result.success?
      puts result.data
    elsif result.error?
      warn result.errors
    end

  end

  private

  def purchase_params
    params.require(:purchase).permit(:category, :scent, :color, :bodyButterWeight, :bodyButterPrice, :price, :addressLine1, :addressLine2, :city, :state, :postalCode, :customerName)
  end

  def initialize_session
    session[:cart] ||= []
  end
end
