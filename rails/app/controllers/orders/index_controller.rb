class Orders::IndexController < ApplicationController
  # 注文一覧
  def index
    @orders = Order.order_recipes_array
  end

  # 注文詳細
  def detail
    recipe_id = params[:id]

    @order_detail = Order.find(params[:order_id])
    @recipe_detail = Recipe.detail(recipe_id)
    @materials = RecipeMaterial.recipe_materials_array(recipe_id)
  end

  # 注文
  def create
    order = Order.create(recipe_id:params[:recipe_id], name_entered: params[:name_entered], user_id: params[:user_id])
  end

  # 作成完了
  def done
    order = Order.find(params[:id])
    order.update(done_flag: true)

    redirect_to '/orders'
  end

  # 作成完了と飲んだの登録
  def done_by_user
    id = params[:id]
    recipe_id = params[:recipe_id]
    user_id = params[:user_id]
    
    review = Review.find_by_user_and_recipe(recipe_id, user_id).first
    if review.nil?
      review = Review.create(recipe_id: recipe_id, user_id: user_id, assessment_id: 1)
    end
    
    order = Order.find(id)
    order.update(done_flag: true)

    redirect_to '/orders'
  end
end
