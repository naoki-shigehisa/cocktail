class Users::IndexController < ApplicationController
  # ユーザーページ
  def show
    @user = User.preload(:rank).find(params[:id])

    unless @user.show_flag
      redirect_to '/'
    end

    @recipes = Recipe.recipes_drank_array(@user.id)
    @user_material_badges = UserMaterialBadge.get_badges_by_user(@user.id)

    favorite_material_id = Review.get_favorite_material_id(@user.id)
    unless favorite_material_id.nil?
      @favorite_material = Material.find(favorite_material_id)
    else
      @favorite_material = nil
    end
  end
  
  # ユーザーランキング
  def ranking
    @user_ranking = User.get_user_ranking
  end

  # ログインページ
  def login_page
    @message = !params[:message].nil?
  end

  # ログイン
  def login
    user_id = User.get_user_id(params[:name], params[:password])
    if user_id.size == 0
      redirect_to '/users/login_page?message=1'
    else
      cookies.permanent[:user_id] = user_id[0]
      redirect_to '/'
    end
  end

  # ログアウト
  def logout
    cookies.delete(:user_id)
    redirect_to '/'
  end
end