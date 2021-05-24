class ApplicationController < ActionController::Base
    def welcome
        render 'layouts/welcome'
    end

    def do_not_come_to_shigehisa
        word_list = [
          "むり",
          "やだ",
          "二度と呼ぶな"
        ]
        apologize_list = [
          "ごめんて...",
          "そんな...",
          "うそでしょ..."
        ]
        @word = word_list[rand(word_list.length)]
        @apologize = apologize_list[rand(apologize_list.length)]
        render 'layouts/do_not_come_to_shigehisa'
    end

    def popular
      @first_order = Recipe.all.order(order_count: "DESC").first
      @second_order = Recipe.all.order(order_count: "DESC").second
      @third_order = Recipe.all.order(order_count: "DESC").third
      render 'layouts/popular'
    end
end
