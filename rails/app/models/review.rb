class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :assessment

  scope :find_by_user, -> (user_id) { where(user_id: user_id) }
  scope :find_by_user_and_recipe, -> (recipe_id, user_id) { where(recipe_id: recipe_id, user_id: user_id) }

  def self.get_assessment(recipe_id, user_id)
    self
      .find_by_user_and_recipe(recipe_id, user_id)
      .first
      &.assessment_id
  end
end
