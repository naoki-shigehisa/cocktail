class ApplicationController < ActionController::Base
    def welcome
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
