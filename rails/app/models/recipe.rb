class Recipe < ApplicationRecord
    has_many :recipe_materials
    has_many :orders
    belongs_to :tech
    belongs_to :style
    belongs_to :alcohol

    def self.detail(recipe_id)
      return self
              .select(:id,:name,:style_id,:tech_id,:alcohol_id)
              .joins(:style,:tech,:alcohol)
              .find(recipe_id)
    end

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
end
