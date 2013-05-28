class ServiceCategory < ActiveRecord::Base
  attr_accessible :name, :notes
  
  def self.getCategories
     categoryFind = self.all
     categories = Array.new
     categoryFind.each do |rt|
       category = Array.new
       category.push(rt.name)
       category.push(rt.id)
       categories.push(category)
     end
     return categories
  end
end
