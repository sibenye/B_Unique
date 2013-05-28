class ServicesController < ApplicationController
  def index
   if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @pages = Page.all
      categories = ServiceCategory.getCategories
      @servicesByCat = Service.getAllByCategory(categories)  
    end 
  end
  
  def new
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @pages = Page.all
      @service = Service.new
      @categories = ServiceCategory.getCategories
      if params[:category] != "" and params[:category] != nil
        @categoryId = params[:category]
        selected = ServiceCategory.find(@categoryId)
        @categories = @categories.insert(0,[selected.name, @categoryId])
      end
      respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @service }
      end
    end
  end
  
  def edit
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @pages = Page.all
    @service = Service.find(params[:id])
    @categoryId = @service.category
    @categories = ServiceCategory.getCategories
    selected = ServiceCategory.find(@categoryId)
    @categories = @categories.insert(0,[selected.name, @categoryId])
  end
  
  def show
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @pages = Page.all
      id = params[:id]
      @service = Service.find(id)
    end
  end
  
  def create
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @service = Service.new(params[:service])
      required_fields = ['name', 'price']
      if !contactFormvalidity(required_fields, @service)
        flash[:error] = "Please fill in the required fields"
        redirect_to new_service_path(params[:service])
      else
        @service.price = @service.price.to_f
        if @service.save
          flash[:notice] = "Your have successfully added a new service"
          redirect_to  services_path  
        else
          flash[:error] = "An Error occured while submitting your service. Please try again"
          redirect_to new_service_path(params[:service])
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
      @service = Service.find(params[:id])
      required_fields = ['name', 'price']
      if !contactFormvalidity(required_fields, params[:service])
        flash[:error] = "Please fill in the required fields"
        redirect_to edit_service_path(@service)
      else
        @serviceParams = params[:service]
        #@serviceParams['price'] = @serviceParams['price'].to_f
        @service.update_attributes!(@serviceParams)
        flash[:notice] = "Service was successfully updated."
        redirect_to services_path
      end
    end
  end
  
  def destroy
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @service = Service.find(params[:id])
      @service.destroy
      flash[:notice] = "'#{@service.name}' service has been deleted."
      redirect_to services_path
    end
  end
end
