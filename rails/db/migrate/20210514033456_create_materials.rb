class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.string :name
      t.boolean :alcohol_flag
      t.boolean :have_flag

      t.timestamps
    end
  end
end
