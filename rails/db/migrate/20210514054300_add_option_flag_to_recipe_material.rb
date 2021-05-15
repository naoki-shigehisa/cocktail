class AddOptionFlagToRecipeMaterial < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_materials, :option_flag, :boolean
  end
end
