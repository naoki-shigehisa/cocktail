class RecipeController < ApplicationController
  def list
    @recipes = Recipe.select(:id,:name)
    @can_recipes = []
    @recipes.each{|recipe|
      have_flag = RecipeMaterial
        .select(:id,:recipe_id,:material_id,:option_flag)
        .includes(:material)
        .where("(recipe_id = ?) AND (option_flag = 0)", recipe.id)
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
