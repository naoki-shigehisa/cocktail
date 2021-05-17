class Material < ApplicationRecord
    has_many :recipe_materials

    # 材料の情報を取得
    def self.detail(material_id)
        return self
                .select(:id,:name,:alcohol_flag,:have_flag)
                .find(material_id)
    end

    # 持っている材料のリストを取得
    def self.have_materials
        return self
                .select(:id,:name,:alcohol_flag,:have_flag)
                .where("have_flag = ?", 1)
                .order(:name)
    end
end
