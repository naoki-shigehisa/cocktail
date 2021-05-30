class RecipeMaterial < ApplicationRecord
    belongs_to :recipe
    belongs_to :material

    scope :base, -> { where("base_flag = ?", true) }

    # 特定のレシピの材料の情報を取得
    def self.recipe_materials_array(recipe_id)
        return self
                .select(:recipe_id,:material_id,:amount,:option_flag)
                .preload(:material)
                .where("recipe_id = ?", recipe_id)
                .map{|m|
                {
                    "id": m.material.id,
                    "name": m.material.name,
                    "alcohol_flag": m.material.alcohol_flag,
                    "have_flag": m.material.have_flag,
                    "amount": m.amount,
                    "option_flag": m.option_flag
                }
                }
    end

    # 特定の材料を使うレシピリストを取得
    def self.recipe_ids_by_material_array(material_id)
        return self
                .select(:recipe_id,:material_id)
                .where("material_id = ?", material_id)
                .map{|r|
                    r.recipe_id
                }
    end
end
