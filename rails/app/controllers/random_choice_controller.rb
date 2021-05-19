class RandomChoiceController < ApplicationController
  # ランダムチョイスの条件選択画面
  def terms
    @styles = Style.all
    @techs = Tech.all
    @alcohols = Alcohol.all
    @materials = Material.have_materials

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

    @recipes = Recipe.recipes_by_terms(params[:style], params[:tech], params[:alcohol]).can_recipes_by_term(@choice_materials, params[:material_mode].to_i)
    if @recipes.empty?
      params[:message] = 1
    end
  end

  # ランダムチョイス
  def order
    @recipes = Recipe.recipes_by_terms(params[:style], params[:tech], params[:alcohol]).can_recipes_by_term(params[:choice_materials].split(','), params[:material_mode].to_i)

    if @recipes.empty?
      redirect_to "/random_choice/terms?style=#{params[:style]}&tech=#{params[:tech]}&alcohol=0&material_mode=#{params[:material_mode]}&choice_materials=#{params[:choice_materials]}&message=1"
    else
      id = @recipes.sample[:id]
      @recipe_detail = Recipe.detail(id)
      @materials = RecipeMaterial.recipe_materials(id)
      render 'recipe/detail'
    end
  end
end
