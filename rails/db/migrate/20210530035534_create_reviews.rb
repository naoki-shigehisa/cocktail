class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false
      t.integer :assessment, null: false, default: 0
      t.string :comment

      t.timestamps
    end
  end
end
