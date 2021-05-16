class RecipeController < ApplicationController
  def list
    @recipes = Recipe.can_recipes
  end

  def detail
    @recipe_detail = Recipe
                      .select(:id,:name,:style_id,:tech_id,:alcohol_id)
                      .joins(:style,:tech,:alcohol)
                      .find(params[:id])
    @materials = RecipeMaterial
                  .select(:recipe_id,:material_id,:amount,:option_flag)
                  .preload(:material)
                  .where("recipe_id = ?", params[:id])
                  .map{|m|
                    {
                      "id": m.material.id,
                      "name": m.material.name,
                      "alcohol_flag": m.material.alcohol_flag,
                      "have_flag": m.material.have_flag,
                      "amount": m.amount,
                      "option_flag": m.option_flag
                    }
                  }
  end

  def all
    @recipes = Recipe
                .all
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
end
