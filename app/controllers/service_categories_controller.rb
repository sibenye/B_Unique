class ServiceCategoriesController < ApplicationController
  def index
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @pages = Page.all
      @service_categories = ServiceCategory.all   
    end 
  end
  
  def new
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @pages = Page.all
      @service_category = ServiceCategory.new
  
      respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @service_category }
      end
    end
  end
  
  def show
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @pages = Page.all
      id = params[:id]
      @service_category = ServiceCategory.find(id)
    end
  end
  
  def create
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @service_category = ServiceCategory.new(params[:service_category])
      required_fields = ['name']
      if !contactFormvalidity(required_fields, @service_category)
         flash[:error] = "Please fill in the required fields"
         redirect_to new_service_category_path(params[:service_category])
      else
        if @service_category.save
          flash[:notice] = "Your have successfully added a new service category"
          redirect_to  service_categories_path  
        else
          flash[:error] = "An Error occured while submitting your service category. Please try again"
          redirect_to new_service_category_path(params[:service_category])
        end
      end
    end
  end
  
  def update
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @service_category = ServiceCategory.find(params[:id])
      required_fields = ['name']
      if !contactFormvalidity(required_fields, params[:service_category])
        flash[:error] = "Please fill in the required fields"
        redirect_to edit_service_category_path(@service_category)
      else
        @service_category.update_attributes!(params[:service_category])
        flash[:notice] = "Service was successfully updated."
        redirect_to service_categories_path
      end
    end
  end
end
