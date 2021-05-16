class MaterialController < ApplicationController
  def list
    @materials = Material
                  .select(:id,:name,:alcohol_flag,:have_flag)
                  .where("have_flag = ?", 1)
  end

  def detail
    @material_detail = Material
                        .select(:id,:name,:alcohol_flag,:have_flag)
                        .find(params[:id])
    recipe_ids = RecipeMaterial
                .select(:recipe_id,:material_id)
                .where("material_id = ?", params[:id])
                .map{|r|
                  r.recipe_id
                }
    @recipes = Recipe
                .select(:id,:name,:style_id,:tech_id,:alcohol_id)
                .preload(:style,:tech,:alcohol)
                .where(id: recipe_ids)
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

  def all
    @materials = Material.all
  end
end
