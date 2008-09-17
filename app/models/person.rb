class Person < ActiveRecord::Base

  belongs_to :father, :class_name=>'Person', :foreign_key=>'father_id'
  belongs_to :mother, :class_name=>'Person', :foreign_key=>'mother_id'

end

