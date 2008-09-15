class PeopleController < ApplicationController

  def get_new_form
    render(:partial=>'new_form')
  end
  
  def create
    @person_list = Person.new(params['person'])  
    @person_list.save
    render(:partial=>'person_list')
  end
  
  def edit
    @person = Person.find(params['id'])
  end
  
  def save
    @person_list = Person.find(params['id'])  
    @person_list.attributes = params['person']
    @person_list.save
  end
  
end
