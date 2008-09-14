class PeopleController < ApplicationController

  def get_new_form
    render(:partial=>'new_form')
  end
  
  def create
    @person = Person.new(params['person'])  
    @person.save
    render(:partial=>'person')
  end
  
end
