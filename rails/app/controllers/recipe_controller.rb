class RecipeController < ApplicationController
  def list
    @recipes = Recipe.can_recipes
  end

  def detail
    if params[:id] == "-1"
      id = Recipe.can_recipes.sample[:id]
    else
      id = params[:id]
    end

    @recipe_detail = Recipe.detail(id)
    @materials = RecipeMaterial.recipe_materials(id)
  end

  def all
    @recipes = Recipe.all_recipes
  end

  def list_only_name
    @recipes = Recipe.can_recipes
  end
end
