class ApplicationsController < ApplicationController
  def index
    @forms = 'selected'
  end
  
  def submission_confirmation
    @forms = 'selected'
    @appCode = params[:appCode]
    if @appCode[0,1].eql?("E")
      id = EmployeeApplication.getId(@appCode)
      if id != nil
        application = EmployeeApplication.find(id)
        if application.submitted_on == Date.today
          from = "buba_employment@bubaonline.com"
          subject_a = "Thank you. Application Received"
          BarberMailer.deliver_confirmation_email_for_employee(application, subject_a, from)
          
          subject_b = "New Employee Application"
          to = "buba_employment@bubaonline.com"
          BarberMailer.deliver_admin_notification_email(application, subject_b, to)
        else
          redirect_to forms_path
        end
      else
          redirect_to forms_path
      end
    else
      id = StudentApplication.getId(@appCode)
      if id != nil
        application = StudentApplication.find(id)
        if application.submitted_on == Date.today
          from = "buba_admissions@bubaonline.com"
          subject_a = "Thank you. Application Received"
          BarberMailer.deliver_confirmation_email_for_student(application, subject_a, from)
          
          subject = "New Student Application"
          to = "buba_admissions@bubaonline.com"
          BarberMailer.deliver_admin_notification_email(application, subject, to)
        else
          redirect_to forms_path
        end
      else
          redirect_to forms_path
      end
    end
  end
end
