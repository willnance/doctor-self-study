# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130302181032) do

  create_table "admins", :force => true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "username"
    t.string   "email"
    t.string   "hashedPassword"
    t.string   "salt"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.string   "response"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "assignments", ["user_id", "question_id"], :name => "index_assignments_on_user_id_and_question_id"

  create_table "questions", :force => true do |t|
    t.string   "subject"
    t.text     "question"
    t.text     "answerA"
    t.text     "answerB"
    t.text     "answerC"
    t.text     "answerD"
    t.text     "solution"
    t.integer  "position"
    t.boolean  "visible"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year"
    t.integer  "rotation"
  end

  create_table "users", :force => true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "username"
    t.string   "hashedPassword"
    t.integer  "year"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "rotation"
  end

end
