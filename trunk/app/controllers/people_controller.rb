class PeopleController < ApplicationController

  protect_from_forgery :except => [:auto_complete_for_search_name] 

  def get_new_form
    render(:partial=>'new_form', :locals=>{:role=>params['role'], :id=>params['id']})
  end
  
  def create
    @person_list = Person.new(params['person'])  
    @person_list.save
    role = params[:role] 
    if role != nil
      add_relation(@person_list.id,role,Person.find(params['for_id'].to_i))
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
    render(:partial=>'add_parent_form', :locals=>{:role=>params['role']})
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
    add_relation(@person.id,params[:role],Person.find(params['for_id'].to_i))
    render(:text=>'Ajouté, mais il faut tout rafraichir, je sais c\'est chiant...')
  end
  
  # id of the new person
  # role of this person: 'father', 'mother'
  # for_who: a person object
  def add_relation(id,role,for_who)
    case role
    when 'father': for_who.father_id = id
    when 'mother': for_who.mother_id = id
    end
    for_who.save
  end

end

