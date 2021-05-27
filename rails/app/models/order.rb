class Order < ApplicationRecord
  belongs_to :recipe

  scope :not_make, -> { where("done_flag = ?", false) }

  def self.order_recipes_array
    return Order
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
end
