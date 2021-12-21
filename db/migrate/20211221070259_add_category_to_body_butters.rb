class AddCategoryToBodyButters < ActiveRecord::Migration[6.0]
  def change
    add_column :body_butters, :category, :string
  end
end
