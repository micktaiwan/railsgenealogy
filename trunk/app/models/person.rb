class Person < ActiveRecord::Base

  #belongs_to :father, :class_name=>'Person', :foreign_key=>'father_id'
  #belongs_to :mother, :class_name=>'Person', :foreign_key=>'from_id', :conditions=>[]
  #has_many :friends, :through => :relations, 

  def father
    Person.find_by_sql("SELECT p.* from people p, relations r WHERE p.id=r.from_id and r.to_id=#{self.id} and r.reltype=0 and p.sex=0")[0]
  end
  
  def mother
    Person.find_by_sql("SELECT p.* from people p, relations r WHERE p.id=r.from_id and r.to_id=#{self.id} and r.reltype=0 and p.sex=1")[0]
  end

  def children
    Person.find_by_sql("SELECT p.* from people p, relations r WHERE p.id=r.to_id and r.from_id=#{self.id} and r.reltype=0")
  end
  
end

