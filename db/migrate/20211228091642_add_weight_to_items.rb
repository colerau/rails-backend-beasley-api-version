class AddWeightToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :weight, :integer
  end
end
