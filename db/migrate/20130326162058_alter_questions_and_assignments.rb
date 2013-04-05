class AlterQuestionsAndAssignments < ActiveRecord::Migration
  def up
    add_column("questions" , "schedule", :datetime)
    add_column("assignments", "correct" , :boolean)
  end

  def down
    remove_column("questions" , "schedule")
    remove_column("assignments", "correct" )
  end
end
