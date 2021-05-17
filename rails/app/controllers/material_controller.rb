class MaterialController < ApplicationController
  # 持っている材料のリスト
  def list
    @materials = Material.have_materials
  end

  # 材料の詳細情婦
  def detail
    @material_detail = Material.detail(params[:id])
    recipe_ids = RecipeMaterial.recipe_ids_by_material(params[:id])
    @recipes = Recipe.where(id: recipe_ids).can_recipes
  end

  # 全ての材料
  def all
    @materials = Material.all.order(:name)
  end
end
