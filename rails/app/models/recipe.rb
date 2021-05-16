class Recipe < ApplicationRecord
    has_many :recipe_materials
    belongs_to :tech
    belongs_to :style
    belongs_to :alcohol

    def self.can_recipes
        recipes = self
                    .select(:id,:name,:style_id,:tech_id,:alcohol_id)
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
        @can_recipes = []
        recipes.each{|recipe|
          have_flag = RecipeMaterial
            .select(:id,:recipe_id,:material_id,:option_flag)
            .includes(:material)
            .where("(recipe_id = ?) AND (option_flag = 0)", recipe[:id])
            .map{|r|
              r.material.have_flag
            }
            .all? {|v| v }
          if have_flag
            @can_recipes << recipe
          end
        }
        @can_recipes
    end
end