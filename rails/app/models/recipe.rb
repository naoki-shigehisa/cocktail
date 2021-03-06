class Recipe < ApplicationRecord
  has_many :recipe_materials
  has_many :orders
  has_many :reviews
  has_many :materials, through: :recipe_materials
  belongs_to :tech
  belongs_to :style
  belongs_to :alcohol
  belongs_to :user, optional: true

  scope :narrow_style, -> (style) { where(style_id: style) }
  scope :narrow_tech, -> (tech) { where(tech_id: tech) }
  scope :narrow_alcohol, -> (alcohol) { where(alcohol_id: alcohol) }

  # 特定のレシピの情報を取得
  def self.detail(recipe_id)
    self
      .select(:id,:name,:style_id,:tech_id,:alcohol_id,:user_id,:excellent_count)
      .preload(:style,:tech,:alcohol)
      .find(recipe_id)
  end

  def get_excellent_count
    self
      .reviews
      .where(assessment_id: 4)
      .count
  end

  # 全てのレシピ情報を取得
  def self.all_recipes_array
    self
      .all
      .order(:name)
      .preload(:style,:tech,:alcohol,recipe_materials: :material)
      .map{|r|
        {
          "id": r.id,
          "name": r.name,
          "style": r.style.name,
          "tech": r.tech.name,
          "alcohol": r.alcohol.name,
          "excellent_count": r.excellent_count,
          "base": r.recipe_materials
                    .map{|r_m|
                      {
                        "name": r_m.material.name,
                        "base_flag": r_m.base_flag
                      } 
                    }
                    .find{|r_m| r_m[:base_flag]}[:name]
        }
      }
  end

  # 今ある材料で作れるレシピを取得
  def self.can_recipes_array
      recipes = self.all_recipes_array

      have_flags = RecipeMaterial
                    .select(:id,:recipe_id,:material_id,:option_flag)
                    .preload(:material)
                    .where(option_flag: 0)
                    .map{|r|
                      {
                        "recipe_id": r.recipe_id,
                        "have_flag": r.material.have_flag
                      }
                    }

      @can_recipes = []
      recipes.each{|recipe|
        have_flag = have_flags.select {|h| h[:recipe_id] == recipe[:id]}.all? {|h| h[:have_flag] }
        if have_flag
          @can_recipes << recipe
        end
      }
      @can_recipes
  end

  # 指定した材料で作れるレシピを取得
  def self.can_recipes_by_term_array(material_ids, mode)
    recipes = self.can_recipes_array
    
    recipe_ids = recipes.pluck(:id)
    materials = RecipeMaterial
                  .select(:id,:recipe_id,:material_id,:option_flag)
                  .where(recipe_id: recipe_ids, option_flag: 0)
                  .map{|r|
                    {
                      "recipe_id": r.recipe_id,
                      "material_id": r.material_id,
                    }
                  }

    @can_recipes = []
    recipes.each{|recipe|
      recipe_materials = materials.select {|m| m[:recipe_id] == recipe[:id]}
      if mode == 0
        can_flag = material_ids.all? {|id| recipe_materials.find { |m| id.to_i == m[:material_id] } }
      elsif mode == 1 
        can_flag = recipe_materials.any? {|m| material_ids.find { |id| id.to_i == m[:material_id] } }
      else
        can_flag = recipe_materials.all? {|m| material_ids.find { |id| id.to_i == m[:material_id] } }
      end

      if can_flag
        @can_recipes << recipe
      end
    }
    @can_recipes
  end

  # レシピを条件で絞り込む
  def self.recipes_by_terms(style_id, tech_id, alcohol_id)
    @recipes = Recipe
    if style_id and style_id != "0"
      @recipes = @recipes.where(style_id: style_id)
    end
    if tech_id and tech_id != "0"
      @recipes = @recipes.where(tech_id: tech_id)
    end
    if alcohol_id and alcohol_id != "0"
      @recipes = @recipes.where(alcohol_id: alcohol_id)
    end

    @recipes
  end

  # 特定のユーザーが飲んだレシピを取得
  def self.recipes_drank_array(user_id)
    self
      .all
      .eager_load(:reviews)
      .where(reviews: {user_id: user_id})
      .order("reviews.created_at desc")
      .preload(:style,:tech,:alcohol,:reviews,recipe_materials: :material,reviews: :assessment)
      .map{|r|
        {
          "id": r.id,
          "name": r.name,
          "style": r.style.name,
          "tech": r.tech.name,
          "alcohol": r.alcohol.name,
          "base": r.recipe_materials
                    .map{|r_m|
                      {
                        "name": r_m.material.name,
                        "base_flag": r_m.base_flag
                      } 
                    }
                    .find{|r_m| r_m[:base_flag]}[:name],
          "assessment": r.reviews.last.assessment.name
        }
      }
  end

  # レシピ情報にユーザーの評価を追加
  def self.add_assessment(recipes, user_id)
    reviews = Review.find_by_user(user_id).preload(:assessment)
    for i in 0...recipes.size
      review = reviews.find{|r| r.recipe_id == recipes[i][:id]}
      unless review.nil?
        recipes[i][:assessment] = review.assessment.name
      end
    end
    recipes
  end
end