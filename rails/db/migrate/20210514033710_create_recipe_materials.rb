class CreateRecipeMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_materials do |t|
      t.integer :recipe_id
      t.integer :material_id
      t.string :amount

      t.timestamps
    end
  end
end
