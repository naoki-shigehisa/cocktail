class UserMaterialBadge < ApplicationRecord
  belongs_to :user
  belongs_to :material

  def self.get_badges_by_user(user_id)
    self
      .where(user_id: user_id)
      .preload(:material)
  end
end
