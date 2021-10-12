class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :assessment

  has_many :recipe_materials, through: :recipe
  has_many :materials, through: :recipe_materials

  scope :find_by_user, -> (user_id) { where(user_id: user_id) }
  scope :find_by_user_and_recipe, -> (recipe_id, user_id) { where(recipe_id: recipe_id, user_id: user_id) }

  after_save :update_user_rank
  after_save :create_user_badge
  after_save :update_excellent_count

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

  def self.get_reviews_from_recipe_id(recipe_id)
    self
      .where(recipe_id: recipe_id)
      .where.not(assessment_id: 1)
      .includes(:user)
      .where(user: {show_flag: true})
      .preload(:assessment)
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

  def create_user_badge
    recipe_materials = self.recipe.materials
                        .where(alcohol_flag: true)
    user_materials = self.user.reviews
                        .includes(:materials)
                        .where.not(assessment_id: 1)
                        .where(materials: {alcohol_flag: true})
                        .map{|review| 
                          review
                            .materials
                            .pluck(:id)
                        }
                        .flatten

    user_id = self.user.id
    recipe_materials.each do |material|
      if user_materials.count(material.id) >= 5
        UserMaterialBadge.find_or_create_by(user_id: user_id, material_id: material.id)
      end
    end
  end

  def update_excellent_count
    excellent_count = self
                        .recipe
                        .reviews
                        .where(assessment_id: 4)
                        .count
    self.recipe.update(excellent_count: excellent_count)
  end
end
