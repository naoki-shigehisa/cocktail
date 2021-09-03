class AddColorToRank < ActiveRecord::Migration[6.1]
  def change
    add_column :ranks, :background_color, :string
    add_column :ranks, :text_color, :string
  end
end
