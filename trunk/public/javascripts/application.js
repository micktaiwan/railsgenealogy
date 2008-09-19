// Genealogy application client scripts

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
  // calculate its position 
  this.add_person = function(id) {
    // First see id this person is already in the graph
    log('graph add_person');
    i = contains(id)
    if(i != -1) {
      log('already in graph');
      p = _graph[i];
      p.highlight();
      }
    else {
      log('adding '+id);
      p = new Person(id);
      _graph.push(p);
      this.organize();
      }    
    return p;
    }
  
  this.erase_person = function(p) {
    //  new Effect.Shrink(p.element);
    p.element.remove();
    }  
  this.clear = function() {
    _graph.each(this.erase_person);
    _graph.clear();
    }
    
    
  function move(p) {
    new Effect.Move(p.element, {x:30,y:40, mode: 'absolute'});
    }
      
  // will recalculate all persons positions
  this.organize = function() {
    _graph.each(move);
    }
}
 

// Class Person
// inputs:
//  DB id of the person
// the DOM element id is assumed to be 'person_'+id
function Person(id) {
  log('new Person '+id);
  this.id = id
  
  this.element = $('person_'+id);
  if(this.element == null) {
    alert('Before adding a element to the graph, you must create it in the DOM');
    return;
    }
  new Draggable(this.element.id);

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
  
  // just hightlight the element 
  this.highlight = function() {
    new Effect.Shake(this.element.id, {duration: 2});
    }
  }

  
// globale variable for the application
var graph = new Graph();

