class AddReviewCountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :review_count, :integer, null: false, default: 0
  end
end
