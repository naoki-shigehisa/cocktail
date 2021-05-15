class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :style_id
      t.integer :tech_id
      t.integer :alcohol_id

      t.timestamps
    end
  end
end
