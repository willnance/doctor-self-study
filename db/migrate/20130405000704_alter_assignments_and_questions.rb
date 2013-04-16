#authors Will Nance and Sanket Prabhu
class AlterAssignmentsAndQuestions < ActiveRecord::Migration
  def up
    add_column("assignments", "responded" , :boolean)
    add_column("assignments", "blank" , :boolean)
    add_column("questions", "explanation" , :string)
  end

  def down
    remove_column("assignments", "responded")
    remove_column("assignments", "blank")
    remove_column("questions", "explanation")
  end
end
