class User < ApplicationRecord
  has_many :reviews
  has_many :orders
  has_many :recipes
  has_many :user_material_badges

  belongs_to :rank

  def self.current_user_id(cookies)
    if cookies[:user_id]
      cookies[:user_id]
    else
      nil
    end
  end

  def self.current_user(cookies)
    if cookies[:user_id]
      self.where(id: cookies[:user_id]).first
    else
      nil
    end
  end

  def self.get_user_id(name, password)
    self
      .select(:id, :name, :password)
      .where(name: name, password: password)
      .pluck(:id)
  end

  def self.get_user_ranking
    self
      .preload(:rank)
      .where(show_flag: true)
      .where.not(review_count: 0)
      .order(review_count: :desc)
  end
end
