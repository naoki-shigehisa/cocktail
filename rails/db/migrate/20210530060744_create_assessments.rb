class CreateAssessments < ActiveRecord::Migration[6.1]
  def change
    create_table :assessments do |t|
      t.string :name

      t.timestamps
    end
  end
end
