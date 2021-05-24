class RecipeController < ApplicationController
  DEFAULT_MODE = "0"
  ALL_SELECT = "99999"
  ALL_RELEASE = "-1"

  # 作れるレシピリスト
  def list
    style = params[:style]
    tech = params[:tech]
    alcohol = params[:alcohol]
    choice_materials = params[:choice_materials]
    material = params[:material]
    material_mode = params[:material_mode]

    @recipes = Recipe
    if style and style != DEFAULT_MODE
      @recipes = @recipes.where("style_id = ?", style)
    else
      style = DEFAULT_MODE
    end
    if tech and tech != DEFAULT_MODE
      @recipes = @recipes.where("tech_id = ?", tech)
    else
      tech = DEFAULT_MODE
    end
    if alcohol and alcohol != DEFAULT_MODE
      @recipes = @recipes.where("alcohol_id = ?", alcohol)
    else
      alcohol = DEFAULT_MODE
    end

    if choice_materials
      @choice_materials = choice_materials.split(',')
      if material
        if material == ALL_SELECT
          @choice_materials = Material
                              .have_materials
                              .map{|m|
                                m.id.to_s
                              }
        elsif material == ALL_RELEASE
          @choice_materials = []
        elsif @choice_materials.find { |id| id == material }
          @choice_materials.delete(material)
        else
          @choice_materials.push(material)
        end
      end
    else
      @choice_materials = Material
                              .have_materials
                              .map{|m|
                                m.id.to_s
                              }
    end

    if not material_mode
      material_mode = DEFAULT_MODE
    end
    @recipes = @recipes.can_recipes_by_term(@choice_materials, material_mode.to_i)

    @styles = Style.all
    @techs = Tech.all
    @alcohols = Alcohol.all
    @materials = Material.have_materials
    @style = style
    @tech = tech
    @alcohol = alcohol
    @material_mode = material_mode
    @open_material = params[:open_material]
  end

  # レシピの詳細情報
  def detail
    recipe_id = params[:id]

    @recipe_detail = Recipe.detail(recipe_id)
    @materials = RecipeMaterial.recipe_materials(recipe_id)
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
