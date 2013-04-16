#authors Will Nance and Sanket Prabhu
class AlterQuestions < ActiveRecord::Migration
  def up
    remove_column("questions" , "visible")
    remove_column("questions" , "position")
  end

  def down
    add_column("questions" , "visible", :boolean)
    add_column("questions" , "position", :int)
  end
end
