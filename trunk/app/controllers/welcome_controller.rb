class WelcomeController < ApplicationController

  def index
    @people = Person.find(:all, :order=>"fam_name,birth,surname")
  end
  
end

