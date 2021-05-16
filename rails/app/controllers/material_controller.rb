class MaterialController < ApplicationController
  def list
    @materials = Material
                  .select(:id,:name,:alcohol_flag,:have_flag)
                  .where("have_flag = ?", 1)
  end

  def detail
    @material_detail = Material
                        .select(:id,:name,:alcohol_flag,:have_flag)
                        .find(params[:id])
    recipe_ids = RecipeMaterial
                .select(:recipe_id,:material_id)
                .where("material_id = ?", params[:id])
                .map{|r|
                  r.recipe_id
                }
    @recipes = Recipe
                .where(id: recipe_ids)
                .can_recipes
  end

  def all
    @materials = Material.all
  end
end
