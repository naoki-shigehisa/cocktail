class RandomChoiceController < ApplicationController
  # ランダムチョイスの条件選択画面
  def terms
    @styles = Style.all
    @techs = Tech.all
    @alcohols = Alcohol.all

    @recipes = Recipe.recipes_by_terms(params[:style], params[:tech], params[:alcohol]).can_recipes
    if @recipes.empty?
      params[:message] = 1
    end
  end

  # ランダムチョイス
  def order
    @recipes = Recipe.recipes_by_terms(params[:style], params[:tech], params[:alcohol]).can_recipes

    if @recipes.empty?
      redirect_to "/random_choice/terms?style=#{params[:style]}&tech=#{params[:tech]}&alcohol=#{params[:alcohol]}&message=1"
    else
      id = @recipes.sample[:id]
      @recipe_detail = Recipe.detail(id)
      @materials = RecipeMaterial.recipe_materials(id)
      render 'recipe/detail'
    end
  end
end
