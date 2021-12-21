class CreateBodyButters < ActiveRecord::Migration[6.0]
  def change
    create_table :body_butters do |t|
      t.string :scent
      t.decimal :price

      t.timestamps
    end
  end
end
