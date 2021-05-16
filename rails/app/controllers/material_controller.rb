class MaterialController < ApplicationController
  def list
    @materials = Material.have_materials
  end

  def detail
    @material_detail = Material.detail(params[:id])
    recipe_ids = RecipeMaterial.recipe_ids_by_material(params[:id])
    @recipes = Recipe.where(id: recipe_ids).can_recipes
  end

  def all
    @materials = Material.all.order(:name)
  end
end
