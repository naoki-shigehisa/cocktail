class Recipe < ApplicationRecord
    has_many :recipe_materials
    belongs_to :tech
    belongs_to :style
    belongs_to :alcohol

    # 特定のレシピの情報を取得
    def self.detail(recipe_id)
      return self
              .select(:id,:name,:style_id,:tech_id,:alcohol_id)
              .joins(:style,:tech,:alcohol)
              .find(recipe_id)
    end

    # 全てのレシピ情報を取得
    def self.all_recipes
      return self
              .all
              .order(:name)
              .preload(:style,:tech,:alcohol)
              .map{|r|
                {
                  "id": r.id,
                  "name": r.name,
                  "style": r.style.name,
                  "tech": r.tech.name,
                  "alcohol": r.alcohol.name
                }
              }
    end

    # 今ある材料で作れるレシピを取得
    def self.can_recipes
        recipes = self
                    .select(:id,:name,:style_id,:tech_id,:alcohol_id)
                    .order(:name)
                    .preload(:style,:tech,:alcohol)
                    .map{|r|
                      {
                        "id": r.id,
                        "name": r.name,
                        "style": r.style.name,
                        "tech": r.tech.name,
                        "alcohol": r.alcohol.name
                      }
                    }
        
        recipe_ids = recipes.map{|r| r[:id]}
        have_flags = RecipeMaterial
                      .select(:id,:recipe_id,:material_id,:option_flag)
                      .preload(:material)
                      .where(recipe_id: recipe_ids, option_flag: 0)
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

    # レシピを条件で絞り込む
    def self.recipes_by_terms(style_id, tech_id, alcohol_id)
      @recipes = Recipe
      if style_id and style_id != "0"
        @recipes = @recipes.where("style_id = ?", style_id)
      end
      if tech_id and tech_id != "0"
        @recipes = @recipes.where("tech_id = ?", tech_id)
      end
      if alcohol_id and alcohol_id != "0"
        @recipes = @recipes.where("alcohol_id = ?", alcohol_id)
      end

      @recipes
    end
end