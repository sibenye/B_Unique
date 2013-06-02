class StudentApplicationsController < ApplicationController
  # GET /student_applications
  # GET /student_applications.xml
  def index
    @path = 's'
    @student_applications = StudentApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @student_applications }
    end
  end

  # GET /student_applications/1
  # GET /student_applications/1.xml
  def show
    @path = 's'
    @new = 'selected'
    @student_application = StudentApplication.find(params[:id])
    @country = Country.getCountryById(@student_application.country)
    
    if !@student_application.employer_country.empty?
      @employerCountry = Country.getCountryById(@student_application.employer_country)
    end
    
    @emergencyCountry = Country.getCountryById(@student_application.emergency_country)
    @state = State.getStateById(@student_application.state)
    if !@student_application.dl_issue.empty?
      @issueState = State.getStateById(@student_application.dl_issue)
    end
    
    if !@student_application.employer_state.empty?
      @employerState = State.getStateById(@student_application.employer_state)
    end
    
    @emergencyState = State.getStateById(@student_application.emergency_state)
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student_application }
    end
  end

  # GET /student_applications/new
  # GET /student_applications/new.xml
  def new
    @path = 's'
    @new = 'selected'
    @student_application = StudentApplication.new
    @countries = Country.getCountries
    @employerCountries = Country.getCountries
    @emergencyCountries = Country.getCountries
    @states = State.getStates
    @issueStates = State.getStates
    @employerStates = State.getStates
    @emergencyStates = State.getStates
    @sessions = StudentApplication.calculateSession
    
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
    
    if params[:admission_session] != "" and params[:admission_session] != nil
      @selectedSession = params[:admission_session]
      @sessions = @sessions.insert(0,[@selectedSession, @selectedSession])
    else
      @sessions = @sessions.insert(0,["", ""])
    end
    
    @referrers = [[params[:referrer],params[:referrer]],['Friend','Friend'],['Yellow Pages','Yellow Pages'],['Drove By','Drove By'],['Other','Other']]
    @education = [[params[:education],params[:education]],['A High School Graduate', 'A High School Graduate'],['Attending College', 'Attending College'],['A GED Graduate', 'A GED Graduate'],
    ['Attending High School', 'Attending High School'], ['Did not complete High School', 'Did not complete High School']]
    #@sessions = [[params[:admission_session],params[:admission_session]],['January Admission','January Admission'],['April Admission','April Admission'],['July Admission','July Admission'],['October Admission','October Admission']]
    
    @date = Date.today
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student_application }
    end
  end

  # GET /student_applications/1/edit
  def edit
    @path = 's'
    @new = 'selected'
    @student_application = StudentApplication.find(params[:id])
    organizeStateAndCountry(@student_application)
    @referrers = [[@student_application.referrer,@student_application.referrer],['Friend','Friend'],['Yellow Pages','Yellow Pages'],['Drove By','Drove By'],['Other','Other']]
    @education = [[@student_application.education,@student_application.education],['A High School Graduate', 'A High School Graduate'],['Attending College', 'Attending College'],['A GED Graduate', 'A GED Graduate'],
    ['Attending High School', 'Attending High School'], ['Did not complete High School', 'Did not complete High School']]
    #S@sessions = [[@student_application.admission_session,@student_application.admission_session],['January Admission','January Admission'],['April Admission','April Admission'],['July Admission','July Admission'],['October Admission','October Admission']]
    
    if @student_application.marital_status.eql?("Married")
        @marriedChecked = "checked"
      elsif @student_application.marital_status.eql?("Single")
        @singleChecked = "checked"
     end
     
     if @student_application.gender.eql?("Female")
        @femaleChecked = "checked"
      elsif @student_application.gender.eql?("Male")
        @maleChecked = "checked"
      end
    
  end

  # POST /student_applications
  # POST /student_applications.xml
  def create
    @student_application = StudentApplication.new(params[:student_application])
    @stparams = params[:student_application]
    required_fields = ['admission_session', 'first_name', 'last_name', 'email', 'marital_status', 'dob', 'gender', 'mobile_phone', 'education', 'address', 'city', 'state', 'zipcode', 'country', 'ssn', 'applying_for', 'student_type', 'period', 'emergency_name', 'emergency_mobile_number', 'emergency_relationship', 'emergency_address', 'emergency_city', 'emergency_state', 'emergency_zipcode', 'emergency_country']
    if !contactFormvalidity(required_fields, @student_application)
        #debugger
        
        flash[:error] = "Please fill in the required fields"
        redirect_to new_student_application_path(params[:student_application])
    elsif @stparams[:signed].eql?("0")
      flash[:error] = "You have to certify that the information you provided is correct. Please check the checkbox at the bottom of form."
        redirect_to new_student_application_path(params[:student_application])
    else
      @student_application.application_code = StudentApplication.generateAppID(@stparams[:first_name], @stparams[:last_name], @stparams[:applying_for])
      if @student_application.save
        flash[:notice] = 'Student Application was successfully created.'
        redirect_to student_application_path(@student_application)
      else
        render :action => "new" 
      end
    end
  end

  # PUT /student_applications/1
  # PUT /student_applications/1.xml
  def update
    @student_application = StudentApplication.find(params[:id])
    @student_application_params = params[:student_application]
    required_fields = ['admission_session', 'first_name', 'last_name', 'email', 'marital_status', 'dob', 'gender', 'mobile_phone', 'education', 'address', 'city', 'state', 'zipcode', 'country', 'ssn', 'applying_for', 'student_type', 'period', 'emergency_name', 'emergency_mobile_number', 'emergency_relationship', 'emergency_address', 'emergency_city', 'emergency_state', 'emergency_zipcode', 'emergency_country']
    if !contactFormvalidity(required_fields, @student_application_params)
        #debugger
        flash[:error] = "Please fill in the required fields"
        if @student_application_params['paid'] == nil or @student_application_params['paid'] == ""
          redirect_to edit_student_application_path(@student_application)
        else
          redirect_to admin_edit_student_application_path(@student_application)
        end        
    else
      @student_application_params['application_code'] = StudentApplication.generateAppID(@student_application_params['first_name'], @student_application_params['last_name'], @student_application_params['applying_for'])

      respond_to do |format|
        if @student_application.update_attributes(@student_application_params)
          if @student_application_params['paid'] == nil or @student_application_params['paid'] == ""
            format.html { redirect_to(@student_application, :notice => 'Student Application was successfully updated.') }
          else
            format.html { redirect_to(manage_student_application_path, :notice => 'Student Application was successfully updated.') }
          end
        else
          if params[:paid] == nil or params[:paid] == ""
            format.html { render :action => "edit" }
          else
            flash[:error] = "Error while updating student application"
            redirect_to admin_edit_student_application_path(@student_application)
          end
        end
      end
    end
  end

  # DELETE /student_applications/1
  # DELETE /student_applications/1.xml
  def destroy
    @student_application = StudentApplication.find(params[:id])
    @student_application.destroy

    respond_to do |format|
      format.html { redirect_to(student_applications_url) }
      format.xml  { head :ok }
    end
  end
  
  def application_status
    @path = 's'
    @status = 'selected'
    if !params[:check].eql?("") and params[:check] != nil
      required_fields = ['app_code', 'first_name', 'last_name']
      if !contactFormvalidity(required_fields, nil)
        #debugger
        flash[:error] = "Please fill in the required fields"
        redirect_to student_application_status_path(:app_code => params[:app_code],:first_name => params[:first_name],:last_name => params[:last_name])
        @check = params[:check]
      else
        @result = StudentApplication.getAppStatus(params[:app_code], params[:first_name], params[:last_name])
        if @result != nil
        @message = @result['message']
        @firstName = params[:first_name]
        @lastName = params[:last_name]
        @appCode = params[:app_code]
        @appliedFor = @result['appliedFor']
        @session = @result['session']
        @submitDate = @result['submitDate']
        end
        @check = params[:check]
      end
    else
      @check = nil 
    end
  end
  
  def search
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      if params[:search] == nil
        @path = 's'
        render
      else
        @path = 's'
        required_fields = ['academic_year', 'academic_period']
        if !contactFormvalidity(required_fields, nil)
        #debugger
        flash[:error] = "All fields are required"
        redirect_to manage_student_application_path
        else
          admission_session = params[:academic_year]+' - '+params[:academic_period]+' Admission'
          @result = StudentApplication.studentApplicationSearch(admission_session)
          #debugger
          @hasResult=true
        end
      end
      
    end
  end
  
  def manage
    if session[:level] == nil or session[:level] == 0
      redirect_to :controller => :administrators, :action => :login
    elsif !Administrator.OnlineAuthenticate(session[:bunique])
      redirect_to :controller => :administrators, :action => :login
    else
      @path = 's'
      @student_application = StudentApplication.find(params[:id])
      organizeStateAndCountry(@student_application)
      if @student_application.accepted == "YES" then
        @decision = "YES"
      elsif @student_application.accepted == "NO" then
        @decision = [['NO','NO'],['YES','YES']]
      else
        @decision = [['PENDING','PENDING'],['NO','NO'],['YES','YES']]
      end
    end
  end
  
  def organizeStateAndCountry(student_application)
    @student_application = student_application
    @countries = Country.getCountries
      @employerCountries = Country.getCountries
      @emergencyCountries = Country.getCountries
      @states = State.getStates
      @issueStates = State.getStates
      @employerStates = State.getStates
      @emergencyStates = State.getStates
      @sessions = StudentApplication.calculateSession
      
      @stateId = @student_application.state
      selected = State.find(@stateId)
      @selectedState = selected.name + " " + selected.abbreviation
      @states = @states.insert(0,[@selectedState, @stateId])
      
      if !@student_application.dl_issue.empty?
        @issueStateId = @student_application.dl_issue
        selected = State.find(@issueStateId)
        @selectedIssueState = selected.name + " " + selected.abbreviation
        @issueStates = @issueStates.insert(0,[@selectedIssueState, @issueStateId])
      else
        @issueStates = @issueStates.insert(0,["", ""])
      end
      
      if !@student_application.employer_state.empty?
        @employerStateId = @student_application.employer_state
        selected = State.find(@employerStateId)
        @selectEdemployerState = selected.name + " " + selected.abbreviation
        @employerStates = @employerStates.insert(0,[@selectedEmployerState, @employerStateId])
      else
        @employerStates = @employerStates.insert(0,["", ""])
      end  
      
      @emergencyStateId = @student_application.emergency_state
      selected = State.find(@emergencyStateId)
      @selectedEmergencyState = selected.name + " " + selected.abbreviation
      @emergencyStates = @emergencyStates.insert(0,[@selectedEmergencyState, @emergencyStateId])
      
      if !@student_application.employer_country.empty?
        @employerCountryId = @student_application.employer_country
        selected = Country.find(@employerCountryId)
        @selectedEmployerCountry = selected.name
        @employerCountries = @employerCountries.insert(0,[@selectedEmployerCountry, @employerCountryId])
      else
        @employerCountries = @employerCountries.insert(0,["", ""])
      end   
      
      @countryId = @student_application.country
      selected = Country.find(@countryId)
      @selectedCountry = selected.name
      @countries = @countries.insert(0,[@selectedCountry, @countryId])
      
      @emergencyCountryId = @student_application.emergency_country
      selected = Country.find(@emergencyCountryId)
      @selectedEmergencyCountry = selected.name
      @emergencyCountries = @emergencyCountries.insert(0,[@selectedEmergencyCountry, @emergencyCountryId])
      
      @selectedSession = @student_application.admission_session
      @sessions = @sessions.insert(0,[@selectedSession, @selectedSession])
  end
 
end
