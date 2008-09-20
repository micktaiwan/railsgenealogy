class WelcomeController < ApplicationController

  protect_from_forgery :except => [:auto_complete_for_search_name] 

  def index
    @people = Person.find(:all, :order=>"fam_name,birth,surname")
  end
  
 
  def auto_complete_for_search_name
    #re = Regexp.new("#{params[:person][:name]}", "i")
    str = params[:search][:name]
    @persons = Person.find(:all,:conditions=>"surname like '%#{str}%' or fam_name like '%#{str}%'").map {|p| p.surname+ " "+p.fam_name}
    render :inline => "<%= content_tag(:ul, @persons.map { |p| content_tag(:li, h(p)) }) %>"
  end

end

