class ApplicationController < ActionController::Base
  before_action :user_info
  def user_info
    current_user = User.current_user(cookies)
    @current_user_id = current_user&.id
    @rank = current_user&.rank
    @material_badges = UserMaterialBadge.get_badges_by_user(@current_user_id)
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
