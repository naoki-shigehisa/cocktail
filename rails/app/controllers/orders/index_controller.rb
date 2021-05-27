class Orders::IndexController < ApplicationController
  def index
    @orders = Order.order_recipes_array
  end

  def create
    order = Order.create(recipe_id:params[:recipe_id], name_entered: params[:name_entered])
    @recipe = Recipe.detail(order.recipe_id)
  end

  def done
    order = Order.find(params[:id])
    order.update(done_flag: true)

    @orders = Order.order_recipes_array
    render '/orders/index/index'
  end
end
