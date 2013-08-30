ShoobPhoto::Application.routes.draw do

  match 'contact' => 'contact#message', :via => 'GET'
  match 'contact' => 'contact#send_message', :via => 'POST'
  get 'contact/job_application'
  match 'contact/job_application' => 'contact#send_job_application', :via => 'POST'

  match 'printing' => 'catalog#printing'
  match 'printing/:product' => 'catalog#printing_product', :via => 'GET'
  match 'printing/:product' => 'cart#add_product', :via => 'POST', :as => 'cart_add_product'

  match 'purchase_pictures' => 'catalog#schools'
  match 'purchase_pictures/:school' => 'catalog#package_types'
  match 'purchase_pictures/:school/:package_type' => 'catalog#packages'
  match 'purchase_pictures/:school/:package_type/:package' => 'catalog#package', :via => 'GET'
  match 'purchase_pictures/:school/:package_type/:package' => 'cart#add_package', :via => 'POST', :as => 'cart_add_package'
  
  match 'senior_portraits/purchase_portraits' => 'catalog#senior_warning'
  
  match 'cart' => 'cart#index'
  match 'cart/:id/destroy_package' => 'cart#destroy', :as => :cart_destroy
  get 'cart/checkout'
  match 'cart/checkout' => 'cart#purchase', :via => :post
  get 'cart/receipt'
  
  match 'file_uploads/:id/:style/:filename' => 'file_upload#show'
  
  match 'barcode/:number' => 'barcodes#show'
  
  match 'download/*file' => 'contact#file', :via => 'GET'
  match 'download/*file' => 'contact#file_download', :via => 'POST', :as => 'download'

  match 'proof/:code' => 'proofs#show'

  match 'admin' => 'admin#index'
  get 'admin/help'
  get 'admin/log'
  scope '/admin' do
    resources :nav_links
    resources :pages
    resources :options
    resources :option_types
    resources :packages
    resources :package_types
    resources :schools
    resources :school_types
    resources :products
    match 'proofs/generate_code' => 'proofs#generate_code'
    match 'proofs/:id/upload_photos' => 'proofs#upload_photos'
    resources :proofs
    resources :orders
      match 'orders/:id/resend_receipt' => 'orders#resend_receipt', :as => 'order_resend_receipt'
    resources :users
    match 'mailer' => 'mailer#index'
    match 'mailer/deliver' => 'mailer#deliver', :via => 'POST'
    
    match 'runners/import' => 'runners#import'
    resources :runners # MODESTO MARATHON
    resources :races # MODESTO MARATHON
  end

  resources :user_sessions

  match 'login' => 'user_sessions#new'

  match 'logout' => 'user_sessions#destroy'

  resource :user

  match '*page' => 'pages#show', :constraints => proc {|request| Page.paths.include? request.fullpath }

  root :to => 'pages#show', :page => 'home'
  
  match 'internal_error.html' => 'errors#five_hundred'
  match '*path' => 'errors#four_oh_four'

end
