class Assessment < ApplicationRecord
    has_many :reviews

    scope :for_review, -> { where("id != ?", 1) }
end
