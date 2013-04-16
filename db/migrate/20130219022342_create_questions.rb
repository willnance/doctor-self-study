#authors Will Nance and Sanket Prabhu
class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string "subject"
      t.text "question"
      t.text "answerA"
      t.text "answerB"
      t.text "answerC"
      t.text "answerD"
      t.text "solution"
      t.integer "position"
      t.boolean "visible"
      t.timestamps
    end
  end
  
  def down
    drop_table :questions
  end
end
