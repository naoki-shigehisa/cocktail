class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :name_entered
      t.boolean :done_flag, null: false, default: false

      t.timestamps
    end
  end
end
