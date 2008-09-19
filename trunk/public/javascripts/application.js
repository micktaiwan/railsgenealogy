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

  // add a person to the graph
  // will verify if the person is already in the graph 
  this.add_person = function(id) {
    // First see id this person is already in the graph
    log('graph add_person');
    i = contains(id)
    if(i != -1) {
      log('already in graph');
      return _graph[i];
      }
    else {
      log('adding '+id);
      p = new Person(id);
      _graph.push(p);
      return p;
      }    
    }
  
  this.erase_person = function(p) {
    //new Effect.Shrink(p.element);
    p.element.remove();
    }  
  this.clear = function() {
    _graph.each(this.erase_person);
    _graph.clear();
    }
}
 

// Class Person
// inputs:
//  DB id of the person
//  text: the text to display
function Person(id) {
  log('new Person '+id);
  this.id = id
  
  this.element = $('person_'+id);
  if(this.element == null) {
    alert('Before adding a element to the graph, you must create it in the DOM');
    return;
    }
  new Draggable(this.element.id);
  new Effect.Shake(this.element.id, {duration: 0.1});
  //new Effect.Move(this.element.id, { x: 20, y: 30, mode: 'relative', delay: 0.1 });

  // the element graphical aspect is generated from a partial
  //db_update(id);
  
  this.update_db = function(id) {
    new Ajax.Request('/person/xxx_todo', {onComplete: function(t) {
        this.element.innerHTML = t.responseText;
        }
      });
    }


  // add all family members in the graphic
  // inputs: DB id of the person
  this.add_family = function() {
    //this.element.innerHTML = 'not done yet';
    }
  
  // just hightlight the element in the graph 
  this.highlight = function() {
    new Effect.Highlight(this.element.id, {duration: 2});
    }
  }

  
// globale variable for the application
var graph = new Graph();

