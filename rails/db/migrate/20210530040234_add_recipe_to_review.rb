class AddRecipeToReview < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :recipe, null: false, foreign_key: true
  end
end
