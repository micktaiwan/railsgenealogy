class CreatePeople < ActiveRecord::Migration
  
  def self.up
    create_table :people do |t|
      t.string "fam_name", :limit => 50
      t.string "surname",  :limit => 50
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
  
end
