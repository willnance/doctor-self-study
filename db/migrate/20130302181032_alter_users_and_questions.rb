class AlterUsersAndQuestions < ActiveRecord::Migration
  def up
    add_column("users", "rotation", :int)
    add_column("questions", "year", :int)
    add_column("questions", "rotation", :int)
  end

  def down
    remove_column("users", "rotation")
    remove_column("questions", "year")
    remove_column("questions", "rotation")
  end
end
