class PagesController < ApplicationController
  #def new
  #  @pages = Page.all
   #  @page = Page.new

  #  respond_to do |format|
   #   format.html # new.html.erb
   #   format.xml  { render :xml => @instructor_application }
   # end
  #end
  
  def edit
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @pages = Page.all
    @page = Page.find(params[:id])
  end
  
  def index
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @pages = Page.all
  end
  
  def show
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    id = params[:id]
    page = Page.find(id)
    redirect_to :action => page.path_name, :id => params[:id]
  end
  
  def create
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
    @page = Page.new(params[:page])
    if @page.save
        flash[:notice] = "Your have successfully added a new page"
        redirect_to :action => @page.path_name   
      else
        flash[:error] = "An Error occured while submitting your Page. Please try again"
        redirect_to new_path(params[:page])
      end
    end
  end
  
  def update
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @page = Page.find(params[:id])
      @page.update_attributes!(params[:page])
      flash[:notice] = "#{@page.title}" + " page was successfully updated."
      redirect_to :action => :index
    end
  end
  
  def about
    @about = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def calendar
    @calendar = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def clinical
    @clinical = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
    categories = ServiceCategory.getCategories
    @servicesByCat = Service.getAllByCategory(categories)  
    
  end
  
  def complaint
    @complaint = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
    if (params[:send] != nil)
      required_fields = ['name', 'address', 'phone', 'email', 'complaint_type', 'message']
      if !contactFormvalidity(required_fields, nil)
        flash[:error] = "All fields are required"
        redirect_to complaint_path
      else
        @content = Hash.new
        @content["body"] = params[:message]
        @content["subject"] = "TEST"
        @content["name"] = params[:name]
        @content["phone"] = params[:phone]
        @content["address"] = params[:address]
        @content["complaint_type"] = params[:complaint_type]
        @content["email"] = params[:email]
        BarberMailer.deliver_complaint_email(@content)
        @sent = true
        flash[:notice] = "Your Complaint is received"
    end
    end
  end
  
  def contact
    @contact = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
    if (params[:send] != nil)
      required_fields = ['name', 'address', 'city', 'state', 'zipcode', 'phone', 'email', 'education', 'start', 'period', 'message']
      if !contactFormvalidity(required_fields, nil)
        flash[:error] = "All fields are required"
        redirect_to contact_path
      else
        @content = Hash.new
        @content["body"] = params[:message]
        @content["subject"] = "TEST"
        @content["name"] = params[:name]
        @content["phone"] = params[:phone]
        @content["address"] = params[:address]
        @content["city"] = params[:city]
        @content["state"] = params[:state]
        @content["zipcode"] = params[:zipcode]
        @content["education"] = params[:education]
        @content["start"] = params[:start]
        @content["period"] = params[:period]
        @content["email"] = params[:email]
        @content["financial_aid"] = params[:financial_aid]? params[:financial_aid] : ""
        @content["admissions"] = params[:admissions]? params[:admissions] : ""
        @content["courses"] = params[:courses]? params[:courses] : ""
        @content["other"] = params[:other]? params[:other] : ""
        BarberMailer.deliver_contact_email(@content)
        to = params[:email]
        sub = "BUBA: Your Message has been received"
        BarberMailer.deliver_customer_notification(getMessage('contact'), to, sub)
        @sent = true
        flash[:notice] = "Your Message has been sent"
      end
    end  
  end
  
  def staff
    @staff = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def events
    @event = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def faq
    @faq = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def financial
    @financial = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def haircare
    @hair = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def friends
    @friends = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def info
    @info = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def home
    @home = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def job
    @job = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def news
    @news = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def owner
    @owner = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def photodetail
    @photo = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def service
    @service = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
  end
  
  def testimony
    @testimony = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
    
  end
  
  def win
    @win = 'selected'
    @pages = Page.all
    @path = params[:action]
    @page = Page.first(:conditions => "path_name = '#{@path}'")
    
  end
end
