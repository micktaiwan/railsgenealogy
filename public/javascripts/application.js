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
      //p.highlight();
      }
    else {
      log('adding '+id);
      p = new Person(id);
      _graph.push(p);
      this.set_position(p);
      //move(p);
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
  
  // calculate position relatively to others
  this.set_position = function(p) {
    p.x = 300;
    p.y = _graph.size()*30+200;
    }  
    
  function move(p) {
    new Effect.Move(p.element, {x:p.x,y:p.y, mode: 'absolute'});
    }
  function get_person(id) {
    index = contains(id);
    if(index==-1) throw('id not found: '+id);
    return _graph[index];
    }

  function __set_pp(p,id,pos) {
    parent = get_person(id);
    parent.x = p.x+pos*234;
    parent.y = p.y-32;
    move(parent);
    }
  function __set_cc(p,id,pos) {
    child = get_person(id);
    child.x = p.x+pos*234;
    child.y = p.y+32;
    move(child);
    }
  
  function set_parents_position(p) {
    for(i=0; i<p.parents.size(); i++) {
      __set_pp(p,p.parents[i],i);
      }
    }    
  function set_children_position(p) {
    for(i=0; i<p.children.size(); i++) {
      __set_cc(p,p.children[i],i);
      }
    }    
  // will recalculate all persons positions, centered on p
  this.organize = function(id) {
    p = get_person(id);
    //p.x = 300;
    //p.y = 300;
    move(p);
    set_parents_position(p);
    set_children_position(p);
    }
}
 

// Class Person
// inputs:
//  DB id of the person
// the DOM element id is assumed to be 'person_'+id
function Person(id) {
  log('new Person '+id);
  this.element = $('person_'+id);
  if(this.element == null) {
    alert('Before adding a element to the graph, you must create it in the DOM');
    return;
    }
  this.element.person = this
  this.id = id
  this.x = 60;
  this.y = 60;
  this.parents = new Array();
  this.children = new Array();
  
  
  function drag_on_end(drag,mouse_event) {
    p = drag.element.person;
    p.x = parseFloat(drag.element.style.left);
    p.y = parseFloat(drag.element.style.top);    
    }
  new Draggable(this.element, {onEnd: drag_on_end});

  // the element graphical aspect is generated from a partial
  //db_update(id);
  
  this.update_db = function(id) {
    new Ajax.Request('/person/xxx_todo', {onComplete: function(t) {
        this.element.innerHTML = t.responseText;
        }
      });
    }

  // add relations to close relatives
  // inputs: DB ids string of the persons
  this.add_relatives = function(parents,children) {
    if(parents !="") this.parents  = parents.split(',');
    if(children!="") this.children = children.split(',');
    }
  
  // just hightlight the element 
  this.highlight = function() {
    new Effect.Shake(this.element.id, {duration: 2});
    }
  }

  
// globale variable for the application
var graph = new Graph();

