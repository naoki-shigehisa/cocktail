class OrdersController < ApplicationController
  before_action :set_order, only: %i[detail done]
  def index
    @orders = Order.where(is_done: false)
  end

  # 注文
  def order
    Order.create(recipe_id: params[:id])
    recipe = Recipe.find(params[:id])
    recipe.update(order_count: recipe.order_count + 1)
    redirect_to '/orders'
  end

  # 完成
  def done
    @order.update(is_done: true)
    redirect_to '/orders'
  end

  # 詳細
  def detail
    @recipe_detail = Recipe.detail(@order.recipe.id)
    @materials = RecipeMaterial.recipe_materials(@order.recipe.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
end
