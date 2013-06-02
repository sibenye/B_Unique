ActionController::Routing::Routes.draw do |map|
  map.resources :administrators

  
  map.resources :employee_applications

  map.resources :student_applications
  
  map.resources :pages
  
  map.resources :services
  
  map.resources :service_categories

  
  map.connect '', :controller => 'pages', :action => 'home'
  map.home 'home', :controller => 'pages', :action => 'home'
  map.about 'about', :controller => 'pages', :action => 'about'
  map.financial 'financial', :controller => 'pages', :action => 'financial'
  map.contact 'contact', :controller => 'pages', :action => 'contact'
  map.owner 'owner', :controller => 'pages', :action => 'owner'
  map.staff 'staff', :controller => 'pages', :action => 'staff'
  map.faq 'faq', :controller => 'pages', :action => 'faq'
  map.job 'job', :controller => 'pages', :action => 'job'
  map.photo 'photodetail', :controller => 'pages', :action => 'photodetail'
  # map.service 'service', :controller => 'pages', :action => 'service'
  map.product 'products', :controller => 'products', :action => 'index'
  map.win 'win', :controller => 'pages', :action => 'win'
  map.forms 'forms', :controller => 'applications', :action => 'index'
  map.friends 'friends', :controller => 'pages', :action => 'friends'
  map.calendar 'calendar', :controller => 'pages', :action => 'calendar'
  map.hair 'haircare', :controller => 'pages', :action => 'haircare'
  map.testimony 'testimony', :controller => 'pages', :action => 'testimony'
  map.advert 'advertise', :controller => 'adverts', :action => 'index'
  map.complaint 'complaint', :controller => 'pages', :action => 'complaint'
  map.news 'news', :controller => 'pages', :action => 'news'
  map.clinical 'clinical', :controller => 'pages', :action => 'clinical'
  map.info 'info', :controller => 'pages', :action => 'info'
  map.gallery 'gallery', :controller => 'photos', :action => 'index'
  map.events 'events', :controller => 'pages', :action => 'events'
  
  map.student_application_status 'student_application/status', :controller => 'student_applications', :action => 'application_status'
  map.employee_application_status 'employee_application/status', :controller => 'employee_applications', :action => 'application_status'
  
  
  map.login 'admin/login', :controller => 'administrators', :action => 'login'
  map.adminLogout 'admin/logout', :controller => 'administrators', :action => 'logout'
  map.dashboard 'admin/dashboard', :controller => 'administrators', :action => 'dashboard'
  
  map.manage_application 'admin/manage_applications', :controller => 'applications', :action => 'manage'
  map.manage_student_application 'admin/manage_applications/student_application', :controller => 'student_applications', :action => 'search'
  map.manage_employee_application 'admin/manage_applications/employee_application', :controller => 'employee_applications', :action => 'search'
  map.admin_edit_student_application 'admin/manage_applications/student_application/:id/manage', :controller => 'student_applications', :action => 'manage'
  
    
  #map.student_application 'student_application', :controller => 'student_applications', :action => 'index'
  #map.edit_student_application 'student_application/:id/edit', :controller => 'student_applications', :action => 'edit'
  #map.new_student_application 'student_application/new', :controller => 'student_applications', :action => 'new'
 
  map.app_submission_confirmation 'submission_confirmation/:appCode', :controller => 'applications', :action => 'submission_confirmation'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
