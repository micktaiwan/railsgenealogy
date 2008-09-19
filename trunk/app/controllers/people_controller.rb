class PeopleController < ApplicationController

  protect_from_forgery :except => [:auto_complete_for_search_name] 

  def get_new_form
    render(:partial=>'new_form', :locals=>{:reltype=>params['reltype'], :id=>params['id']})
  end
  
  def create
    @person_list = Person.new(params['person'])  
    @person_list.save
    type = params['reltype'] 
    if type != nil
      add_relation(@person_list.id,type.to_i,params['for_id'].to_i)
    end
    
    render(:partial=>'person_list')
  end
  
  def edit
    @person = Person.find(params['id'])
  end
  
  def save
    @person = Person.find(params['id'])  
    @person.attributes = params['person']
    @person.save
  end
  
  def view
    @person = Person.find(params['id'])
  end
  
  def add_parent_form
    @person = Person.find(params['id'])
    render(:partial=>'add_parent_form', :locals=>{:reltype=>params['reltype']})
  end
  
  def auto_complete_for_search_name
    #re = Regexp.new("#{params[:person][:name]}", "i")
    str = params[:search][:name]
    @persons = Person.find(:all,:conditions=>"surname like '%#{str}%' or fam_name like '%#{str}%'").map {|p| p.surname+ " "+p.fam_name}
    render :inline => "<%= content_tag(:ul, @persons.map { |p| content_tag(:li, h(p)) }) %>"
  end

  def add_rel
    name =  params[:search][:name].split(' ')
    @person = Person.find_by_surname_and_fam_name(name[0],name[1])
    if(@person == nil)
      render(:text=>'Pas trouvé '+params[:search][:name]+', mais en même c\'est pas éttonant avec ma fonction de merde', :status=>500)
      return
    end
    add_relation(@person.id,params['reltype'].to_i,params['for_id'].to_i)
    render(:text=>'Ajouté, mais il faut tout rafraichir, je sais c\'est chiant...')
  end
  
  # id of the new person
  # type of this person: 'father', 'mother'
  # for_who: a person object
  def add_relation(from_id,reltype,to_id,notes=nil)
    r = Relation.new(:from_id=>from_id,:reltype=>reltype,:to_id=>to_id,:notes=>notes)
    r.save
  end

  def del_rel
    from = params['from_id']
    to = params['to_id']
    reltype = params['reltype']
    Relation.delete_all(["from_id=? and to_id=? and reltype=?",from,to,reltype])
    render(:text=>'ok')
  end 
  
  
end

