class Order < ApplicationRecord
  belongs_to :recipe

  scope :not_make, -> { where("done_flag = ?", false) }

  def self.order_recipes_array
    return Recipe
            .all
            .order(:name)
            .where("id=?",self.not_make.map{|order| order.recipe_id})
            .preload(:style,:tech,:alcohol)
            .map{|r|
              {
                "id": r.id,
                "name": r.name,
                "style": r.style.name,
                "tech": r.tech.name,
                "alcohol": r.alcohol.name
              }
            }
  end
end
