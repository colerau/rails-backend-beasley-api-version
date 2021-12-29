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

  private

  def purchase_params
    params.require(:purchase).permit(:category, :scent, :color, :bodyButterWeight, :bodyButterPrice)
  end

  def initialize_session
    session[:cart] ||= []
  end
end
