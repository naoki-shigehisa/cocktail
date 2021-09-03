class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :assessment

  has_many :recipe_materials, through: :recipe
  has_many :materials, through: :recipe_materials

  scope :find_by_user, -> (user_id) { where(user_id: user_id) }
  scope :find_by_user_and_recipe, -> (recipe_id, user_id) { where(recipe_id: recipe_id, user_id: user_id) }

  def self.get_assessment(recipe_id, user_id)
    self
      .find_by_user_and_recipe(recipe_id, user_id)
      .first
      &.assessment_id
  end

  def self.get_favorite_material_id(user_id)
    self
      .find_by_user(user_id)
      .includes(:materials)
      .where(materials: {alcohol_flag: true})
      .map{|review| 
        review
          .materials
          .pluck(:id)
      }
      .flatten
      .group_by(&:itself).max_by{|_,v| v.size}.first
  end
end
