class AddExcellentCountToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :excellent_count, :integer, default: 0
  end
end
