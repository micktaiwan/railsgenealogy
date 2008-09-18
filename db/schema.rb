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

ActiveRecord::Schema.define(:version => 20080914130750) do

  create_table "people", :force => true do |t|
    t.string   "fam_name",   :limit => 50
    t.string   "surname",    :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sex"
    t.date     "birth"
    t.date     "death"
    t.text     "notes"
  end

  create_table "relations", :id => false, :force => true do |t|
    t.integer "from_id", :null => false
    t.integer "to_id",   :null => false
    t.integer "reltype", :null => false
    t.text    "notes",   :null => true
  end

end
