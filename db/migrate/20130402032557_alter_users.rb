#authors Will Nance and Sanket Prabhu
class AlterUsers < ActiveRecord::Migration
  def up
    add_column("users", "salt", :string)
  end

  def down
    remove_column("users", "salt")
  end
end
