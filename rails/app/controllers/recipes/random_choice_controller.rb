class Recipes::RandomChoiceController < ApplicationController
  DEFAULT_MODE = "0"
  ALL_SELECT = "99999"
  ALL_RELEASE = "-1"

  # ランダムチョイスの条件選択画面
  def terms
    style = params[:style]
    tech = params[:tech]
    alcohol = params[:alcohol]
    choice_materials = params[:choice_materials]
    material = params[:material]
    material_mode = params[:material_mode]

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

    @recipes = Recipe
                .recipes_by_terms(style, tech, alcohol)
                .can_recipes_by_term_array(@choice_materials, material_mode.to_i)
    if @recipes.empty?
      @message = 1
    end

    @current_user = User.current_user(cookies)

    @styles = Style.all
    @techs = Tech.all
    @alcohols = Alcohol.all
    @materials = Material.have_materials

    @style = style
    @tech = tech
    @alcohol = alcohol
    @material_mode = material_mode
  end

  # ランダムチョイス
  def order
    style = params[:style]
    tech = params[:tech]
    alcohol = params[:alcohol]
    choice_materials = params[:choice_materials]
    material_mode = params[:material_mode]

    @recipes = Recipe.recipes_by_terms(style, tech, alcohol).can_recipes_by_term_array(choice_materials.split(','), material_mode.to_i)

    if @recipes.empty?
      redirect_to "/recipes/random_choice/terms?style=#{style}&tech=#{tech}&alcohol=#{alcohol}&material_mode=#{material_mode}&choice_materials=#{choice_materials}&message=1"
    else
      id = @recipes.sample[:id]
      @recipe_detail = Recipe.detail(id)
      @materials = RecipeMaterial.recipe_materials_array(id)
      @assessments = Assessment.for_review
      
      @current_user = User.current_user(cookies)
      unless @current_user.nil?
        @assessment = Review.get_assessment(@recipe_detail.id, @current_user.id)
      end
      render 'recipes/index/detail'
    end
  end

  # シークレットランダムチョイス
  def order_secret
    style = params[:style]
    tech = params[:tech]
    alcohol = params[:alcohol]
    choice_materials = params[:choice_materials]
    material_mode = params[:material_mode]

    @recipes = Recipe.recipes_by_terms(style, tech, alcohol).can_recipes_by_term_array(choice_materials.split(','), material_mode.to_i)

    if @recipes.empty?
      redirect_to "/recipes/random_choice/terms?style=#{style}&tech=#{tech}&alcohol=#{alcohol}&material_mode=#{material_mode}&choice_materials=#{choice_materials}&message=1"
    else
      id = @recipes.sample[:id]
      order = Order.create(recipe_id:id, name_entered: params[:name_entered], user_id: params[:user_id])
      render 'orders/index/create'
    end
  end
end
