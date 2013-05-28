# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details


  def contactFormvalidity(required_fields, obj)
    
    required_fields.each do |r|
      if obj == nil
        if params[r] == ""
          return false
        end
      else
        if obj[r] == "" or obj[r] == nil
        return false
      end
      end
    end
    return true
  end
  
  def getChecked()
    if params[:agree] != ""
      return "checked"
    end
  end
  
  def getMessage(template)
    message = Hash.new("")
    if template.eql?('contact')
      message['body']='Thank you for your interest in B-Unique Barber Academy, we are in receipt of you request for information and one of our specialists will be in contact with you soon.'
      return message
    end
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
