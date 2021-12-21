class CartsController < ApplicationController
  before_action :initialize_session

  def add_to_cart
    # product_category will be name of a model
    product_category = cart_params[:category].delete(' ').classify.constantize

    if product_category == "BubbleCandle"
      options = product_category.where(scent: cart_params[:scent])
      color = cart_params[:color]
      product = options.where(color: color)
    else 
      product = product_category.find_by(scent: cart_params[:scent])
    end

    if product[:color]
      session[:cart] << {category: product[:category], scent: product[:scent], color: product[:color]}
    elsif !product[:color]
      session[:cart] << {category: product[:category], scent: product[:scent]}
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
  end

  def show_cart
    render json: session[:cart]
  end

  private

  def cart_params
    params.require(:cart).permit(:category, :scent, :color)
  end

  def initialize_session
    session[:cart] ||= []
  end

end
