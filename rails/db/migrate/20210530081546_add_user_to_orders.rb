class AddUserToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :user, foreign_key: true
  end
end
