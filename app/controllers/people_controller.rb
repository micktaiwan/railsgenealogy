class PeopleController < ApplicationController

  def get_new_form
    render(:partial=>'new_form', :locals=>{:role=>params['role'], :id=>params['id']})
  end
  
  def create
    @person_list = Person.new(params['person'])  
    @person_list.save
    role = params[:role] 
    if role != nil
      @for = Person.find(params['for_id'].to_i)
      case role
      when 'father': @for.father_id = @person_list.id
      when 'mother': @for.mother_id = @person_list.id
      end
      @for.save
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
  
end

