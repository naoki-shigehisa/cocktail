class Assessment < ApplicationRecord
  has_many :reviews

  scope :for_review, -> { where.not(id: 1) }
end
