// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// Log helper
function log(t) {
  if (console && console.debug) console.debug(t);
  }

// Class Graph
// manage all the persons on the browser canvas 
function Graph() {
  
  var _graph = new Array();
  
  function contains(v) {
    for (var i in _graph) {if (_graph[i].id==v) return i;}
    return -1;
    }

  this.add_person = function(id, text) {
    // First see id this person is already in the graph
    log('graph add_person');
    i = contains(id)
    if(i != -1) {
      log('already in graph');
      return _graph[i];
      }
    else {
      p = new Person(id,text);
      _graph.push(p);
      return p;
      }    
    }

}
 

// Class Person
// inputs: DB id of the person 
function Person(id, text) {
  log('new Person '+id+' '+text);
  this.id = id
  this.element = document.createElement('div');
  this.element.innerHTML = text;
  $('edit').appendChild(this.element);
  this.element.setAttribute('id','person_'+id);
  this.element.setAttribute('class','person');
  new Draggable(this.element.id);
  //new Effect.Move(this.element.id, { x: 20, y: 30, mode: 'relative', delay: 0.1 });
  new Effect.Shake(this.element.id, {duration: 0.1});

  // add all family members in the graphic
  // inputs: DB id of the person
  this.add_family = function() {
    //this.element.innerHTML = 'not done yet';
    }
    
  this.highlight = function() {
    new Effect.Highlight(this.element.id, {duration: 2});
    }
  }

  
 // globale variable for the application
 var graph = new Graph();
 