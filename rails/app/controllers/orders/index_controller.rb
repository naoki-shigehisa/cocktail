class Orders::IndexController < ApplicationController
  # 注文一覧
  def index
    @orders = Order.order_recipes_array
  end

  # 注文詳細
  def detail
    recipe_id = params[:id]

    @order_id = params[:order_id]
    @recipe_detail = Recipe.detail(recipe_id)
    @materials = RecipeMaterial.recipe_materials_array(recipe_id)
  end

  # 注文
  def create
    order = Order.create(recipe_id:params[:recipe_id], name_entered: params[:name_entered])
  end

  # 作成完了
  def done
    order = Order.find(params[:id])
    order.update(done_flag: true)

    @orders = Order.order_recipes_array
    render '/orders/index/index'
  end
end
