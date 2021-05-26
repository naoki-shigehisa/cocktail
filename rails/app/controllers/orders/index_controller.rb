class Orders::IndexController < ApplicationController
  def index
      @orders = Orders.all
  end
end
