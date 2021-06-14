class Recipes::IndexController < ApplicationController
  DEFAULT_MODE = "0"
  ALL_SELECT = "99999"
  ALL_RELEASE = "-1"

  # 作れるレシピリスト
  def menu
    style = params[:style]
    tech = params[:tech]
    alcohol = params[:alcohol]
    choice_materials = params[:choice_materials]
    material = params[:material]
    material_mode = params[:material_mode]

    @recipes = Recipe
    if style and style != DEFAULT_MODE
      @recipes = @recipes.narrow_style(style)
    else
      style = DEFAULT_MODE
    end
    if tech and tech != DEFAULT_MODE
      @recipes = @recipes.narrow_tech(tech)
    else
      tech = DEFAULT_MODE
    end
    if alcohol and alcohol != DEFAULT_MODE
      @recipes = @recipes.narrow_alcohol(alcohol)
    else
      alcohol = DEFAULT_MODE
    end

    if choice_materials
      @choice_materials = choice_materials.split(',')
      if material
        if material == ALL_SELECT
          @choice_materials = Material.have_material_ids_array
        elsif material == ALL_RELEASE
          @choice_materials = []
        elsif @choice_materials.find { |id| id == material }
          @choice_materials.delete(material)
        else
          @choice_materials.push(material)
        end
      end
    else
      @choice_materials = []
    end

    unless material_mode
      material_mode = DEFAULT_MODE
    end
    @recipes = @recipes.can_recipes_by_term_array(@choice_materials, material_mode.to_i)

    current_user = User.current_user_id(cookies)
    unless current_user.nil?
      @recipes = Recipe.add_assessment(@recipes, current_user)
    end

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
    @materials = RecipeMaterial.recipe_materials_array(recipe_id)
    @assessments = Assessment.for_review

    @current_user = User.current_user(cookies)
    unless @current_user.nil?
      @assessment = Review.get_assessment(@recipe_detail.id, @current_user.id)
    end
  end

  # 全てのレシピ
  def all
    @recipes = Recipe.all_recipes_array
  end

  # 作れるレシピのリスト(レシピ名だけを表示)
  def menu_only_name
    @recipes = Recipe.can_recipes_array
  end

  # 飲んだレシピを表示
  def drank
    current_user_id = User.current_user_id(cookies)
    unless current_user_id.nil?
      @recipes = Recipe.recipes_drank_array(current_user_id)
    else
      @recipes = []
    end
  end
end
