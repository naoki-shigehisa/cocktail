class RecipeController < ApplicationController
  # 作れるレシピリスト
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

    if params[:choice_materials]
      @choice_materials = params[:choice_materials].split(',')
      if params[:material]
        if params[:material] == "99999"
          @choice_materials = Material
                              .have_materials
                              .map{|m|
                                m.id.to_s
                              }
        elsif params[:material] == "-1"
          @choice_materials = []
        elsif @choice_materials.find { |id| id == params[:material] }
          @choice_materials.delete(params[:material])
        else
          @choice_materials.push(params[:material])
        end
      end
    else
      @choice_materials = Material
                              .have_materials
                              .map{|m|
                                m.id.to_s
                              }
    end

    if not params[:material_mode]
      params[:material_mode] = "0"
    end
    @recipes = @recipes.can_recipes_by_term(@choice_materials, params[:material_mode].to_i)

    @styles = Style.all
    @techs = Tech.all
    @alcohols = Alcohol.all
    @materials = Material.have_materials
  end

  # レシピの詳細情報
  def detail
    @recipe_detail = Recipe.detail(params[:id])
    @materials = RecipeMaterial.recipe_materials(params[:id])
  end

  # 全てのレシピ
  def all
    @recipes = Recipe.all_recipes
  end

  # 作れるレシピのリスト(レシピ名だけを表示)
  def list_only_name
    @recipes = Recipe.can_recipes
  end
end
