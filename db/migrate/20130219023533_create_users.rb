class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "firstName"
      t.string "lastName"
      t.string "username"
      t.string "hashedPassword"
      t.integer "year"
      t.timestamps
    end
  end
  def down
    drop_table :users
  end
end
