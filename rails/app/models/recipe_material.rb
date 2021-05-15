class RecipeMaterial < ApplicationRecord
    belongs_to :recipe
    belongs_to :material
end
