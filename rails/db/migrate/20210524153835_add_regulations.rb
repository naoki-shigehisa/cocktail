class AddRegulations < ActiveRecord::Migration[6.1]
    def change
      change_column_null :alcohols, :name, false, 0
      change_column_null :styles, :name, false, 0
      change_column_null :teches, :name, false, 0

      change_column_null :materials, :name, false, 0
      change_column_null :materials, :alcohol_flag, false, 0
      change_column_default :materials, :alcohol_flag, from: nil, to: false
      change_column_null :materials, :have_flag, false, 0
      change_column_default :materials, :have_flag, from: nil, to: false

      change_column_null :recipe_materials, :recipe_id, false, 0
      change_column_null :recipe_materials, :material_id, false, 0
      change_column_null :recipe_materials, :amount, false, 0
      change_column_null :recipe_materials, :option_flag, false, 0
      change_column_default :recipe_materials, :option_flag, from: nil, to: false
      change_column_null :recipe_materials, :base_flag, false, 0
      change_column_default :recipe_materials, :base_flag, from: nil, to: false

      change_column_null :recipes, :name, false, 0
      change_column_null :recipes, :style_id, false, 0
      change_column_null :recipes, :tech_id, false, 0
      change_column_null :recipes, :alcohol_id, false, 0
    end
  end