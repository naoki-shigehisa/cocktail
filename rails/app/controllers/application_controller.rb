class ApplicationController < ActionController::Base
    def welcome
        render 'layouts/welcome'
    end

    def do_not_come_to_shigehisa
        word_num = rand(3)
        if word_num == 0
            @word = "むり"
        elsif word_num == 1
            @word = "やだ"
        else
            @word = "二度と呼ぶな"
        end
        render 'layouts/do_not_come_to_shigehisa'
    end
end
