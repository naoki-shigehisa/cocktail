class CreateUserMaterialBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :user_material_badges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true

      t.timestamps
    end
  end
end
