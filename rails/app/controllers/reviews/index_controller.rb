class Reviews::IndexController < ApplicationController
    protect_from_forgery
    
    def create
        recipe_id = params[:recipe_id]
        user_id = params[:user_id]
        assessment = params[:assessment]

        review = Review.find_by_user_and_recipe(recipe_id, user_id).first
        if review.nil?
            review = Review.create(recipe_id: recipe_id, user_id: user_id, assessment_id: assessment)
        else
            review.update(assessment_id: assessment)
        end

        redirect_to '/recipes/detail/' + recipe_id
    end
end