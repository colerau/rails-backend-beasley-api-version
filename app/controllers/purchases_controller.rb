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
    product_name_string = "#{session[:cart][:category]} (#{session[:cart][:scent]}"

    if session[:cart][:color]
      product_name_string += ", #{session[:cart][:color]})"
    end
    if session[:cart][:bodyButterWeight]
      product_name_string += ", #{session[:cart][:bodyButterWeight]})"
    end

    if session[:cart][:bodyButterPrice]
      api_call_item_base_price = session[:cart][:bodyButterPrice].to_i * 100
    end
    if session[:cart][:price]
      api_call_item_base_price = session[:cart][:price].to_i * 100
    end

    tax = (api_call_item_base_price * 0.1040).to_i

    # Create an instance of the API Client and initialize it with the credentials 
    # for the Square account whose assets you want to manage.
    client = Square::Client.new(
      access_token: ENV["sandbox_access_token"],
      environment: 'sandbox'
    )

    api_call_body = {
        idempotency_key: SecureRandom.uuid,
        order: {
          order: {
            location_id: ENV["sandbox_location_id"],
            line_items: [
              {
                name: product_name_string,
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
                      address_line_1: purchase_params[:addressLine1],
                      address_line_2: purchase_params[:addressLine2],
                      locality: purchase_params[:city],
                      administrative_district_level_1: purchase_params[:state],
                      postal_code: purchase_params[:postalCode],
                      country: "US"
                    }
                  }
                }
              }
            ]
          },
          idempotency_key: SecureRandom.uuid
        },
        merchant_support_email: "mistybeasley@beasleyscents.com"
      }

    result = client.checkout.create_checkout(
      location_id: ENV["sandbox_location_id"], body: api_call_body
    )

    if result.success?
      puts result.data
      render json: {success: result.data.checkout[:checkout_page_url]}
    elsif result.error?
      warn result.errors
      render json: {error: "Error: Could not pay with Square."}
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
