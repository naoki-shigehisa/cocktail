class Material < ApplicationRecord
    has_many :recipe_materials

    # 材料の情報を取得
    def self.detail(material_id)
        self
            .select(:id,:name,:alcohol_flag,:have_flag)
            .find(material_id)
    end

    # 持っている材料のリストを取得
    def self.have_materials
        self
            .select(:id,:name,:alcohol_flag,:have_flag)
            .where("have_flag = ?", 1)
            .order(:name)
    end

    # 持っている材料のidを配列で取得
    def self.have_material_ids_array
        self
            .have_materials
            .map{|m|
                m.id.to_s
            }
    end
end
