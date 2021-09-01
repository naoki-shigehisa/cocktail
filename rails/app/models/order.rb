class Order < ApplicationRecord
  belongs_to :recipe
  belongs_to :user, optional: true

  scope :not_make, -> { where(done_flag: false) }

  def self.order_recipes_array
    Order
      .not_make
      .preload(:recipe)
      .map{|o|
        {
          "id": o.id,
          "name_entered": o.name_entered,
          "recipe_id": o.recipe.id,
          "name": o.recipe.name,
        }
      }
  end

  def self.my_order_recipes_array(user_id)
    Order
      .not_make
      .where(user_id: user_id)
      .preload(:recipe)
      .map{|o|
        {
          "id": o.id,
          "name_entered": o.name_entered,
          "recipe_id": o.recipe.id,
          "name": o.recipe.name,
        }
      }
  end
end
