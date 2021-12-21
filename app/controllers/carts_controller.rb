class CartsController < ApplicationController
  before_action :initialize_session

  def add_to_cart
    # product_category will be name of a model
    # product_category = cart_params[:category].delete(' ').classify.constantize

    # if product_category == "BubbleCandle"
    #   options = product_category.where(scent: cart_params[:scent])
    #   color = cart_params[:color]
    #   product = options.where(color: color)
    # else 

    # ? product for some reason is inside an array of length 1
    # ! Needs to be refactored into a helper method
    if cart_params[:category] == "Bubble Candle"
      product = Item.where(category: cart_params[:category], scent: cart_params[:scent], color: cart_params[:color])[0]
    else
      product = Item.where(category: cart_params[:category], scent: cart_params[:scent])[0]
    end

    if product[:color]
      session[:cart] << {id: product[:id], category: product[:category], scent: product[:scent], color: product[:color]}
    elsif !product[:color]
      session[:cart] << {id: product[:id], category: product[:category], scent: product[:scent]}
      render json: { message: "Item successfully added to cart", cart: session[:cart] }
    else
      render json: { errors: "Product not found. Could not add product to cart", cart: session[:cart] }
    end

    # binding.pry
    # if product
  
    #   session[:cart] << product.scent
   
    #   render json: { message: "Item successfully added to cart", cart: session[:cart] }
    #   binding.pry
    # else 
    #   render json: { errors: "Product not found. Could not add product to cart" }
    # end
  end

  def remove_from_cart
    # id = params[:id].to_i
    # session[:cart].delete(id)
    # redirect_to root_path

    # * get product, remove product from cart

  
    # product_category = cart_params[:category].delete(' ').classify.constantize
    # binding.pry

    # if product_category == "BubbleCandle"
    #   options = product_category.where(scent: cart_params[:scent])
    #   color = cart_params[:color]
    #   product = options.where(color: color)
    # else 
    #   product = product_category.find_by(scent: cart_params[:scent])
    #   binding.pry
    # end

    # ? product for some reason is inside an array of length 1
    # ! Needs to be refactored into a helper method
    product = Item.find(cart_params[:id])
    if product 
      if product[:category] == "Bubble Candle"
        session[:cart].delete({id: product[:id], category: product[:category], scent: product[:scent], color: product[:color]})
      else
        session[:cart].delete({id: product[:id], category: product[:category], scent: product[:scent]})
      end
  
      render json: {cart: session[:cart]}
    else 
      render json: {error: "Could not find product to remove"}
    end

  end

  def show_cart
    render json: session[:cart]
  end

  def clear_cart
    reset_session
    render json: {message: "cart cleared"}
  end

  private

  def cart_params
    params.require(:cart).permit(:id, :category, :scent, :color)
  end

  def initialize_session
    session[:cart] ||= []
  end

end
