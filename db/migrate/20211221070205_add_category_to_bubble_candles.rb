class AddCategoryToBubbleCandles < ActiveRecord::Migration[6.0]
  def change
    add_column :bubble_candles, :category, :string
  end
end
