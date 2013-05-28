class State < ActiveRecord::Base
  attr_accessible :name, :abbreviation
  
  def self.getStates
     stateFind = self.all
     states = Array.new
     stateFind.each do |rt|
       state = Array.new
       state.push(rt.name + " " + rt.abbreviation)
       state.push(rt.id)
       states.push(state)
     end
     return states
  end
  
  def self.getStateById(id)
    row = self.find(id)
    return row.name
  end
  
  
end
