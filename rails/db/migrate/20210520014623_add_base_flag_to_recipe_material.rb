class AddBaseFlagToRecipeMaterial < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_materials, :base_flag, :boolean
  end
end
