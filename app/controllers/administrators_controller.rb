class AdministratorsController < ApplicationController
  # GET /administrators
  # GET /administrators.xml
  def index
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @administrators = Administrator.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @administrators }
    end
  end

  # GET /administrators/1
  # GET /administrators/1.xml
  def show
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @administrator = Administrator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @administrator }
    end
  end

  # GET /administrators/new
  # GET /administrators/new.xml
  def new
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @administrator = Administrator.new
    @date = Date.today
    @levels = [['1','1'],['2','2'],['3','3']]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @administrator }
    end
  end

  # GET /administrators/1/edit
  def edit
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @administrator = Administrator.find(params[:id])
    @date = Date.today
    @levels = Array.new
    @levels = [['1','1'],['2','2'],['3','3']]
    @userlevel = Array.new
    @userlevel.push(@administrator.clearance)
    @userlevel.push(@administrator.clearance)
    @levels.push(@userlevel)
  end

  # POST /administrators
  # POST /administrators.xml
  def create
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @administrator = Administrator.new(params[:administrator])

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to(administrators_path, :notice => 'Administrator was successfully created.') }
        format.xml  { render :xml => @administrator, :status => :created, :location => @administrator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @administrator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /administrators/1
  # PUT /administrators/1.xml
  def update
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @administrator = Administrator.find(params[:id])
    
    respond_to do |format|
      if @administrator.update_attributes(params[:administrator])
        format.html { redirect_to(administrators_path, :notice => 'Administrator was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @administrator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /administrators/1
  # DELETE /administrators/1.xml
  def destroy
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
    @administrator = Administrator.find(params[:id])
    @administrator.destroy

    respond_to do |format|
      format.html { redirect_to(administrators_url) }
      format.xml  { head :ok }
    end
  end
  
  def login
    if session[:level] != nil and session[:level] != 0 and session[:bunique] != nil
      redirect_to(dashboard_path)
    end
    if params[:commit]
      @message = Administrator.validateInput(params[:username], params[:password])
      if @message == nil
        if Administrator.authenticate(params[:username], params[:password])
          @administrator = Administrator.findByUsername(params[:username])
          session[:level] = @administrator.clearance
          session[:adminName] = @administrator.admin_name
          session[:bunique] = @administrator.username
          redirect_to(dashboard_path)
        else
          flash[:error] = 'Invalid Username or Password!'
        end
      else
       flash[:error] = @message
      end
    else
      #login.html.erb
    end
  end
  
  def logout
    session[:level] = nil
    session[:adminName] = nil
    redirect_to(home_path)
  end
  
  def dashboard
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    end
  end
end
