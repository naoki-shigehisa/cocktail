class ApplicationController < ActionController::Base
    def welcome
        render 'layouts/welcome'
    end

    def come_to_shigehisa
        word_num = rand(3)
        if word_num == 0
            @word = "「呼んだ？」"
        elsif word_num == 1
            @word = "「やだ」"
        else
            @word = "「二度と呼ぶな」"
        end
        render 'layouts/come_to_shigehisa'
    end
end
