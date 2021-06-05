class ApplicationController < ActionController::Base
    before_action :get_current_user_id
    def get_current_user_id
      @current_user_id=User.current_user_id(cookies)
    end

    def welcome
        @current_user = User.current_user(cookies)
        render 'layouts/welcome'
    end

    def do_not_come_to_shigehisa
        word_list = [
          "むり",
          "やだ",
          "二度と呼ぶな",
          "自分でやれよ"
        ]
        apologize_list = [
          "ごめんて...",
          "そんな...",
          "うそでしょ...",
          "すいません"
        ]
        @word = word_list[rand(word_list.length)]
        @apologize = apologize_list[rand(apologize_list.length)]
        render 'layouts/do_not_come_to_shigehisa'
    end
end
