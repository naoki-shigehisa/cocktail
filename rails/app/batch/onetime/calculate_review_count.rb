class Batch::Onetime::CalculateReviewCount
  def self.run
    User.all.each{|u|
      review_count = u.reviews
        .where.not(assessment_id: 1)
        .count
      if review_count < 3
        u.update(rank_id: 1, review_count: review_count)
      elsif review_count < 5
        u.update(rank_id: 2, review_count: review_count)
      elsif review_count < 10
        u.update(rank_id: 3, review_count: review_count)
      elsif review_count < 30
        u.update(rank_id: 4, review_count: review_count)
      elsif review_count < 50
        u.update(rank_id: 5, review_count: review_count)
      else
        u.update(rank_id: 6, review_count: review_count)
      end
    }
  end
end