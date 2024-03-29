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

  def parents
    Person.find_by_sql("SELECT p.* from people p, relations r WHERE p.id=r.from_id and r.to_id=#{self.id} and r.reltype=0")
  end

  def parents_ids
    parents.map{|p| p.id}.join(',')
  end

  def children
    Person.find_by_sql("SELECT p.* from people p, relations r WHERE p.id=r.to_id and r.from_id=#{self.id} and r.reltype=0")
  end
  
  def children_ids
    children.map{|p| p.id}.join(',')
  end
  
  # parents and childrens
  def close_relatives
    Person.find_by_sql("SELECT p.* from relations r join people p on p.id=r.from_id where (r.to_id=#{self.id}) and r.reltype=0 union SELECT p.* from relations r join people p on p.id=r.to_id where (r.from_id=#{self.id}) and r.reltype=0")
  end
  
end

