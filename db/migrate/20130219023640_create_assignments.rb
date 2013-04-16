#authors Will Nance and Sanket Prabhu
class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :user
      t.references :question
      t.string "response"
      t.timestamps
    end
    add_index :assignments , ["user_id", "question_id"]
  end
  def down
    drop_table :assignments
  end
end
