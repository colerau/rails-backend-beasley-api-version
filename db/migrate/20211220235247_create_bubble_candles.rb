class CreateBubbleCandles < ActiveRecord::Migration[6.0]
  def change
    create_table :bubble_candles do |t|
      t.string :scent
      t.decimal :price
      t.string :color

      t.timestamps
    end
  end
end
