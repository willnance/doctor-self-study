class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string "firstName"
      t.string "lastName"
      t.string "username"
      t.string "hashedPassword"
      t.timestamps
    end
  end
  def down
    drop_table :admins
  end
end
