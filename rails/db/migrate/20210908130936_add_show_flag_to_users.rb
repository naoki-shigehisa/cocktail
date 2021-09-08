class AddShowFlagToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :show_flag, :boolean, default: true
  end
end
