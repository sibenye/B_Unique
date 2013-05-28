class Country < ActiveRecord::Base
  attr_accessible :name
  
  def self.getCountries
     countryFind = self.all
     countries = Array.new
     countryFind.each do |rt|
       country = Array.new
       country.push(rt.name)
       country.push(rt.id)
       countries.push(country)
     end
     return countries
  end
  
  def self.getCountryById(id)
    row = self.find(id)
    return row.name
  end
  
  
end
