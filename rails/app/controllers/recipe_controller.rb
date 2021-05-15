class RecipeController < ApplicationController
  def list
    recipes = Recipe
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
        .where("(recipe_id = ?) AND (option_flag = 0)", recipe["id"])
        .map{|r|
          r.material.have_flag
        }
        .all? {|v| v }
      if have_flag
        @can_recipes << recipe
      end
    }
  end
end
