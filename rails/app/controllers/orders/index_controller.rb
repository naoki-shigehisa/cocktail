class Orders::IndexController < ApplicationController
  def index
      @recipes = Orders.order_recipes_array
  end

  def create
    order = Order.new(recipe_id:params[:recipe_id], name_entered: params[:name_entered])
    @recipe = Recipe.detail(order.recipe_id)
  end
end
