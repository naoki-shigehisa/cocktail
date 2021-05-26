class Orders::IndexController < ApplicationController
  def index
      @recipes = Orders.order_recipes_array
  end
end
