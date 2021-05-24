class AddColumnRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :order_count, :integer, null: false, default: 0
  end
end
