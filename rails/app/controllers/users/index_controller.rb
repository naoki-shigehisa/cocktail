class Users::IndexController < ApplicationController
    # ログインページ
    def login_page
        if params[:message]
            @message = true
        else
            @message = false
        end
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