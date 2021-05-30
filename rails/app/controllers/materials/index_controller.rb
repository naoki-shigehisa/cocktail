class Materials::IndexController < ApplicationController
  # 持っている材料のリスト
  def menu
    @materials = Material.have_materials
  end

  # 材料の詳細情婦
  def detail
    material_id = params[:id]
    
    @material_detail = Material.detail(material_id)
    recipe_ids = RecipeMaterial.recipe_ids_by_material_array(material_id)
    @recipes = Recipe.where(id: recipe_ids).can_recipes_array

    current_user = User.current_user_id(cookies)
    if not current_user.nil?
      @recipes = Recipe.add_assessment(@recipes, current_user)
    end
  end

  # 全ての材料
  def all
    @materials = Material.all.order(:name)
  end
end
