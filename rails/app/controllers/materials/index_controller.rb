class Materials::IndexController < ApplicationController
  # 持っている材料のリスト
  def list
    @materials = Material.have_materials
  end

  # 材料の詳細情婦
  def detail
    material_id = params[:id]
    
    @material_detail = Material.detail(material_id)
    recipe_ids = RecipeMaterial.recipe_ids_by_material_array(material_id)
    @recipes = Recipe.where(id: recipe_ids).can_recipes_array
  end

  # 全ての材料
  def all
    @materials = Material.all.order(:name)
  end
end
