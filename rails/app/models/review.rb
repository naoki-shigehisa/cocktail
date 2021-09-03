class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :assessment

  has_many :recipe_materials, through: :recipe
  has_many :materials, through: :recipe_materials

  scope :find_by_user, -> (user_id) { where(user_id: user_id) }
  scope :find_by_user_and_recipe, -> (recipe_id, user_id) { where(recipe_id: recipe_id, user_id: user_id) }

  before_save :update_user_rank

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
      .group_by(&:itself).max_by{|_,v| v.size}&.first
  end

  private

  def update_user_rank
    review_count = self.user.reviews
                    .where.not(assessment_id: 1)
                    .count
    if review_count < 3
      self.user.update(rank_id: 1, review_count: review_count)
    elsif review_count < 5
      self.user.update(rank_id: 2, review_count: review_count)
    elsif review_count < 10
      self.user.update(rank_id: 3, review_count: review_count)
    elsif review_count < 30
      self.user.update(rank_id: 4, review_count: review_count)
    elsif review_count < 50
      self.user.update(rank_id: 5, review_count: review_count)
    else
      self.user.update(rank_id: 6, review_count: review_count)
    end
  end
end
