class CartsController < ApplicationController
  before_action :initialize_session

  def add_to_cart
    # product_category will be name of a model
    # product_category = cart_params[:category].delete(' ').classify.constantize
    # #! need to add code for if two products have same scent but diff colors
    # binding.pry
    # if product
  
    #   session[:cart] << product.scent
   
    #   render json: { message: "Item successfully added to cart", cart: session[:cart] }
    #   binding.pry
    # else 
    #   render json: { errors: "Product not found. Could not add product to cart" }
    # end

    # session[:cart] = 
  end

  def remove_from_cart
    # id = params[:id].to_i
    # session[:cart].delete(id)
    # redirect_to root_path
  end

  private

  def cart_params
    params.require(:cart).permit(:category, :scent, :color)
  end

  def initialize_session
    session[:cart] ||= []
  end

end
