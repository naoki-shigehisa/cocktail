class Recipe < ApplicationRecord
    has_many :recipe_materials
    belongs_to :tech
    belongs_to :style
    belongs_to :alcohol
end
