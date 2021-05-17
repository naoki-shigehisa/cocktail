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
    @recipes = @recipes.can_recipes

    if request.referer&.include?("/recipe/list")
      if params[:material]
        if params[:choice_materials].find { |id| id == params[:material] }
          params[:material].delete(params[:material])
        else
          params[:material].push(params[:material])
        end
      end
    else
      params[:choice_materials] = Material
                                  .have_materials
                                  .map{|m|
                                    m.id
                                  }
    end

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
