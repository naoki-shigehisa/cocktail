class RemoveAssessmentFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :assessment, :int
  end
end
