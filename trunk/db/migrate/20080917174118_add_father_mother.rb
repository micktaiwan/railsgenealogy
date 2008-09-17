class AddFatherMother < ActiveRecord::Migration
  def self.up
    add_column :people, :father_id, :integer, :null => true
    add_column :people, :mother_id, :integer, :null => true
  end

  def self.down
    remove_column :people, :father
    remove_column :people, :mother
  end
end
