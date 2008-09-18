class CreatePeople < ActiveRecord::Migration
  
  def self.up
    
    create_table "people" do |t|
      t.string   "fam_name",   :limit => 50
      t.string   "surname",    :limit => 50
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "sex"
      t.date     "birth"
      t.date     "death"
      t.text     "notes"
    end

    create_table "relations", :id => false do |t|
      t.integer "from_id", :null => false
      t.integer "to_id",   :null => false
      t.integer "reltype", :null => false # 0: direct parent (mother father) 1: friends
      t.text    "notes",   :null => true # notes on relationship (for example, for friend, we could descript where we met)
    end

  end

  def self.down
    drop_table :people
    drop_table :relations    
  end
  
end

