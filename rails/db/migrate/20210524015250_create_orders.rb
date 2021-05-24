class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :recipe_id
      t.boolean :is_done, null: false, default: false

      t.timestamps
    end
  end
end
