class RecipeController < ApplicationController
  def list
    @recipes = Recipe

    if params[:style] and params[:style] != "0"
      @recipes = @recipes.where("style_id = ?", params[:style])
    else
      params[:style] = "0"
    end

    if params[:tech] and params[:tech] != "0"
      @recipes = @recipes.where("tech_id = ?", params[:tech])
    else
      params[:tech] = "0"
    end

    if params[:alcohol] and params[:alcohol] != "0"
      @recipes = @recipes.where("alcohol_id = ?", params[:alcohol])
    else
      params[:alcohol] = "0"
    end

    @recipes = @recipes.can_recipes

    @styles = Style.all
    @techs = Tech.all
    @alcohols = Alcohol.all
  end

  def detail
    @recipe_detail = Recipe.detail(params[:id])
    @materials = RecipeMaterial.recipe_materials(params[:id])
  end

  def all
    @recipes = Recipe.all_recipes
  end

  def list_only_name
    @recipes = Recipe.can_recipes
  end
end
