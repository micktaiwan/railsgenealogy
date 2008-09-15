// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



// Class Graph
// manage all the persons on the browser canvas 
function Graph() {

}
 

// Class Person
// inputs: DB id of the person 
function Person(id, text) {
  this.id = id
  this.element = document.createElement('div');
  this.element.innerHTML = text;
  $('edit').appendChild(this.element);
  this.element.setAttribute('id','person_'+id);
  this.element.setAttribute('class','person');
  new Draggable(this.element.id);

  // add all family members in the graphic
  // inputs: DB id of the person
  this.add_family = function() {
    //this.element.innerHTML = 'not done yet';
    }
  
  }


