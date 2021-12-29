class PurchasesController < ApplicationController

  def purchase 
    purchase_params

    product = purchase_params
  end

  private

  def purchase_params
    params.require(:purchase).permit(:category, :scent, :color, :bodyButterWeight, :bodyButterPrice)
  end
end
