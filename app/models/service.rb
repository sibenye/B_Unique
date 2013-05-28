class Service < ActiveRecord::Base
  attr_accessible :name, :description1,:description2, :price, :category
  
  def self.getAllByCategory(categories)
    services = Hash.new
    serviceList = self.all
    categories.each do |rt|
      service = Array.new
      serviceList.each do |sv|
        if sv.category == rt[1]
          service.push(sv)
        end
        services[rt[0]] = service
      end
    end
    return services
  end
end
