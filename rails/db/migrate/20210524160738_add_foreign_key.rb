class AddForeignKey < ActiveRecord::Migration[6.1]
    def change
      change_column :recipe_materials, :recipe_id, :integer, limit: 8
      add_foreign_key :recipe_materials, :recipes
      change_column :recipe_materials, :material_id, :integer, limit: 8
      add_foreign_key :recipe_materials, :materials

      change_column :recipes, :style_id, :integer, limit: 8
      add_foreign_key :recipes, :styles
      change_column :recipes, :tech_id, :integer, limit: 8
      add_foreign_key :recipes, :teches
      change_column :recipes, :alcohol_id, :integer, limit: 8
      add_foreign_key :recipes, :alcohols
    end
  end