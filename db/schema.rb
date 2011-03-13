# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110313190521) do

  create_table "distinct_wordhits", :force => true do |t|
    t.integer  "keyword_id"
    t.string   "actual_word"
    t.integer  "occurrances"
    t.integer  "words_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "word_searches", :force => true do |t|
    t.string   "keyword"
    t.text     "results_yahoo"
    t.text     "results_twitter"
    t.integer  "search_hitcount_per_ten_mins"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "google_results"
  end

  create_table "words", :force => true do |t|
    t.string   "actual_word"
    t.integer  "total_counts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
