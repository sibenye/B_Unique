class EmployeeApplicationsController < ApplicationController
  # GET /instructor_applications
  # GET /instructor_applications.xml
  def index
    @path = 'e'
    @employee_applications = EmployeeApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employee_applications }
    end
  end

  # GET /instructor_applications/1
  # GET /instructor_applications/1.xml
  def show
    @new = 'selected'
    @path = 'e'
    @employee_application = EmployeeApplication.find(params[:id])
    @country = Country.getCountryById(@employee_application.country)
    
    if !@employee_application.employer_country.empty?
      @employerCountry = Country.getCountryById(@employee_application.employer_country)
    end
    
    @emergencyCountry = Country.getCountryById(@employee_application.emergency_country)
    @state = State.getStateById(@employee_application.state)
    @issueState = State.getStateById(@employee_application.dl_issue)
    
    if !@employee_application.employer_state.empty?
      @employerState = State.getStateById(@employee_application.employer_state)
    end
    
    @emergencyState = State.getStateById(@employee_application.emergency_state)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employee_application }
    end
  end

  # GET /instructor_applications/new
  # GET /instructor_applications/new.xml
  def new
    @new = 'selected'
    @path = 'e'
    @employee_application = EmployeeApplication.new
    
    @countries = Country.getCountries
    @employerCountries = Country.getCountries
    @emergencyCountries = Country.getCountries
    @states = State.getStates
    @issueStates = State.getStates
    @employerStates = State.getStates
    @emergencyStates = State.getStates
    
    if params[:country] != "" and params[:country] != nil
      @countryId = params[:country]
      selected = Country.find(@countryId)
      @selectedCountry = selected.name
      @countries = @countries.insert(0,[@selectedCountry, @countryId])
    else
      @countries = @countries.insert(0,["", ""])
    end
    
    if params[:employer_country] != "" and params[:employer_country] != nil
      @employerCountryId = params[:employer_country]
      selected = Country.find(@employerCountryId)
      @selectedEmployerCountry = selected.name
      @employerCountries = @employerCountries.insert(0,[@selectedEmployerCountry, @employerCountryId])
    else
      @employerCountries = @employerCountries.insert(0,["", ""])
    end
    
    if params[:emergency_country] != "" and params[:emergency_country] != nil
      @emergencyCountryId = params[:emergency_country]
      selected = Country.find(@emergencyCountryId)
      @selectedEmergencyCountry = selected.name
      @emergencyCountries = @emergencyCountries.insert(0,[@selectedEmergencyCountry, @emergencyCountryId])
    else
      @emergencyCountries = @emergencyCountries.insert(0,["", ""])
    end
    
    if params[:state] != "" and params[:state] != nil
      @stateId = params[:state]
      selected = State.find(@stateId)
      @selectedState = selected.name + " " + selected.abbreviation
      @states = @states.insert(0,[@selectedState, @stateId])
    else
      @states = @states.insert(0,["", ""])
    end  
    
    if params[:dl_issue] != "" and params[:dl_issue] != nil
      @issueStateId = params[:dl_issue]
      selected = State.find(@issueStateId)
      @selectedIssueState = selected.name + " " + selected.abbreviation
      @issueStates = @issueStates.insert(0,[@selectedIssueState, @issueStateId])
    else
      @issueStates = @issueStates.insert(0,["", ""])
    end  
    
    if params[:employer_state] != "" and params[:employer_state] != nil
      @employerStateId = params[:employer_state]
      selected = State.find(@employerStateId)
      @selectEdemployerState = selected.name + " " + selected.abbreviation
      @employerStates = @employerStates.insert(0,[@selectedEmployerState, @employerStateId])
    else
      @employerStates = @employerStates.insert(0,["", ""])
    end  
    
    if params[:emergency_state] != "" and params[:emergency_state] != nil
      @emergencyStateId = params[:emergency_state]
      selected = State.find(@emergencyStateId)
      @selectedEmergencyState = selected.name + " " + selected.abbreviation
      @emergencyStates = @emergencyStates.insert(0,[@selectedEmergencyState, @emergencyStateId])
    else
      @emergencyStates = @emergencyStates.insert(0,["", ""])
    end  
    
    if params[:marital_status]
      if params[:marital_status].eql?("Married")
        @marriedChecked = "checked"
      elsif params[:marital_status].eql?("Single")
        @singleChecked = "checked"
      end
    end
    
    if params[:gender]
      if params[:gender].eql?("Female")
        @femaleChecked = "checked"
      elsif params[:gender].eql?("Male")
        @maleChecked = "checked"
      end
    end
    
    @referrers = [[params[:referrer],params[:referrer]],['Friend','Friend'],['Yellow Pages','Yellow Pages'],['Drove By','Drove By'],['Other','Other']]
    @education = [[params[:education],params[:education]], ['A College Graduate', 'A College Graduate'], ['A High School Graduate', 'A High School Graduate'],['Attending College', 'Attending College'],['A GED Graduate', 'A GED Graduate'],
    ['Attending High School', 'Attending High School'], ['Did not complete High School', 'Did not complete High School']]
    @positions = [[params[:applying_for],params[:applying_for]],['Instructor','Instructor'],['Administrator','Administrator']]
    @date = Date.today


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employee_application }
    end
  end

  # GET /instructor_applications/1/edit
  def edit
    @new = 'selected'
    @path = 'e'
    @employee_application = EmployeeApplication.find(params[:id])
    
    @countries = Country.getCountries
    @employerCountries = Country.getCountries
    @emergencyCountries = Country.getCountries
    @states = State.getStates
    @issueStates = State.getStates
    @employerStates = State.getStates
    @emergencyStates = State.getStates
    
    @stateId = @employee_application.state
    selected = State.find(@stateId)
    @selectedState = selected.name + " " + selected.abbreviation
    @states = @states.insert(0,[@selectedState, @stateId])
    
    @issueStateId = @employee_application.dl_issue
    selected = State.find(@issueStateId)
    @selectedIssueState = selected.name + " " + selected.abbreviation
    @issueStates = @issueStates.insert(0,[@selectedIssueState, @issueStateId])
    
    if !@employee_application.employer_state.empty?
      @employerStateId = @employee_application.employer_state
      selected = State.find(@employerStateId)
      @selectEdemployerState = selected.name + " " + selected.abbreviation
      @employerStates = @employerStates.insert(0,[@selectedEmployerState, @employerStateId])
    else
      @employerStates = @employerStates.insert(0,["", ""])
    end  
    
    @emergencyStateId = @employee_application.emergency_state
    selected = State.find(@emergencyStateId)
    @selectedEmergencyState = selected.name + " " + selected.abbreviation
    @emergencyStates = @emergencyStates.insert(0,[@selectedEmergencyState, @emergencyStateId])
    
    if !@employee_application.employer_country.empty?
      @employerCountryId = @employee_application.employer_country
      selected = Country.find(@employerCountryId)
      @selectedEmployerCountry = selected.name
      @employerCountries = @employerCountries.insert(0,[@selectedEmployerCountry, @employerCountryId])
    else
      @employerCountries = @employerCountries.insert(0,["", ""])
    end   
    
    @countryId = @employee_application.country
    selected = Country.find(@countryId)
    @selectedCountry = selected.name
    @countries = @countries.insert(0,[@selectedCountry, @countryId])
    
    @emergencyCountryId = @employee_application.emergency_country
    selected = Country.find(@emergencyCountryId)
    @selectedEmergencyCountry = selected.name
    @emergencyCountries = @emergencyCountries.insert(0,[@selectedEmergencyCountry, @emergencyCountryId])
    
    @referrers = [[@employee_application.referrer,@employee_application.referrer],['Friend','Friend'],['Yellow Pages','Yellow Pages'],['Drove By','Drove By'],['Other','Other']]
    @education = [[@employee_application.education,@employee_application.education],['A College Graduate', 'A College Graduate'], ['A High School Graduate', 'A High School Graduate'],['Attending College', 'Attending College'],['A GED Graduate', 'A GED Graduate'],
    ['Attending High School', 'Attending High School'], ['Did not complete High School', 'Did not complete High School']]
    @positions = [[@employee_application.applying_for,@employee_application.applying_for],['Instructor','Instructor'],['Administrator','Administrator']]
    
    if @employee_application.marital_status.eql?("Married")
        @marriedChecked = "checked"
      elsif @employee_application.marital_status.eql?("Single")
        @singleChecked = "checked"
     end
     
     if @employee_application.gender.eql?("Female")
        @femaleChecked = "checked"
      elsif @employee_application.gender.eql?("Male")
        @maleChecked = "checked"
      end

  end

  # POST /instructor_applications
  # POST /instructor_applications.xml
  def create
    @employee_application = EmployeeApplication.new(params[:employee_application])

   @stparams = params[:employee_application]
    required_fields = ['experience', 'first_name', 'last_name', 'email', 'marital_status', 'dob', 'gender', 'mobile_phone', 'education', 'address', 'city', 'state', 'zipcode', 'country', 'ssn', 'applying_for', 'employment_type', 'period', 'emergency_name', 'emergency_mobile_number', 'emergency_relationship', 'emergency_address', 'emergency_city', 'emergency_state', 'emergency_zipcode', 'emergency_country']
    if !contactFormvalidity(required_fields, @employee_application)
        #debugger
        
        flash[:error] = "Please fill in the required fields"
        redirect_to new_employee_application_path(params[:employee_application])
    elsif @stparams[:signed].eql?("0")
      flash[:error] = "You have to certify that the information you provided is correct. Please check the checkbox at the bottom of form."
        redirect_to new_employee_application_path(params[:employee_application])
    else
      @employee_application.application_code = EmployeeApplication.generateAppID(@stparams[:first_name], @stparams[:last_name], @stparams[:applying_for])
      if @employee_application.save
        flash[:notice] = 'Employee Application was successfully created.'
        redirect_to employee_application_path(@employee_application)
      else
        render :action => "new" 
      end
    end

  end

  # PUT /instructor_applications/1
  # PUT /instructor_applications/1.xml
  def update
    @employee_application = EmployeeApplication.find(params[:id])
    @employee_application_params = params[:employee_application]
    required_fields = ['experience', 'first_name', 'last_name', 'email', 'marital_status', 'dob', 'gender', 'mobile_phone', 'education', 'address', 'city', 'state', 'zipcode', 'country', 'ssn', 'applying_for', 'employment_type', 'period', 'emergency_name', 'emergency_mobile_number', 'emergency_relationship', 'emergency_address', 'emergency_city', 'emergency_state', 'emergency_zipcode', 'emergency_country']
    if !contactFormvalidity(required_fields, @employee_application_params)
        #debugger
        
        flash[:error] = "Please fill in the required fields"
        redirect_to edit_employee_application_path(@employee_application)
        
    else
      @employee_application_params['application_code'] = EmployeeApplication.generateAppID(@employee_application_params['first_name'], @employee_application_params['last_name'], @employee_application_params['applying_for'])

      respond_to do |format|
        if @employee_application.update_attributes(@employee_application_params)
          format.html { redirect_to(@employee_application, :notice => 'Employee Application was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @employee_application.errors, :status => :unprocessable_entity }
        end
      end
    end

  end

  # DELETE /instructor_applications/1
  # DELETE /instructor_applications/1.xml
  def destroy
    @employee_application = EmployeeApplication.find(params[:id])
    @employee_application.destroy

    respond_to do |format|
      format.html { redirect_to(employee_applications_url) }
      format.xml  { head :ok }
    end
  end
  
  def application_status
    @path = 'e'
    @status = 'selected'
    if !params[:check].eql?("") and params[:check] != nil
      required_fields = ['app_code', 'first_name', 'last_name']
      if !contactFormvalidity(required_fields, nil)
        #debugger
        flash[:error] = "Please fill in the required fields"
        redirect_to student_application_status_path(:app_code => params[:app_code],:first_name => params[:first_name],:last_name => params[:last_name])
        @check = params[:check]
      else
        @result = EmployeeApplication.getAppStatus(params[:app_code], params[:first_name], params[:last_name])
        if @result != nil
        @message = @result['message']
        @firstName = params[:first_name]
        @lastName = params[:last_name]
        @appCode = params[:app_code]
        @appliedFor = @result['appliedFor']
        @submitDate = @result['submitDate']
        end
        @check = params[:check]
      end
    else
      @check = nil 
    end
  end
  
  def manage
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      render
    end
  end
end
