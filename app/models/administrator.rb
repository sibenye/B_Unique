class Administrator < ActiveRecord::Base
  attr_accessible :admin_name, :username, :password, :clearance, :created_at, :modified_at
  
  def self.validateInput(username, password)
    message = nil
    if username.empty? or password.empty?
      message = 'Username and Password required!'
    elsif username.length >30 or password.length > 30
      message = 'Character length too long, please try again!'
    end
    return message
  end
  
  def self.authenticate(username, password)
    @adminUser = Administrator.first(:conditions => "username = '#{username}'")
    if @adminUser != nil
      if @adminUser.password == password
        return true
      end
      
    else
      return false
    end
    return false
  end
  
  def self.OnlineAuthenticate(username)
    admin = self.first(:conditions => "username = '#{username}'")
    if admin == nil
      return false
    else
      return true
    end
  end
  
  def self.findByUsername(username)
    admin = self.first(:conditions => "username = '#{username}'")
    return admin
  end
  
end
