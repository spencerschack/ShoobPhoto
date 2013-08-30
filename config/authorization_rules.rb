authorization do
  role :admin do
    has_permission_on [:proofs, :users, :pages, :nav_links, :school_types, :schools, :package_types, :packages, :option_types, :options, :products, :file_uploads, :orders, :runners], :to => :manage
    has_permission_on :mailer, :to => [:index, :deliver]
    has_permission_on :runners, :to => :import
    has_permission_on :admin, :to => [:index, :help, :log]
    has_permission_on :orders, :to => :resend_receipt
    has_permission_on :proofs, :to => :generate_code
  end
  
  role :guest do
  	has_permission_on [:pages, :nav_links, :school_types, :schools, :package_types, :packages], :to => [:index, :show]
  	has_permission_on [:proofs], :to => [:show]
  	has_permission_on :file_uploads, :to => :show do
  	  if_attribute :line_item_id => is_in {LineItem.where('cart_id = :cart_id OR order_id = :order_id', :cart_id => session[:cart_id], :order_id => session[:order_id]).map(&:id)}
	  end
	  has_permission_on :users, :to => [:new, :create, :show, :edit, :update, :destroy] do
	    if_attribute :id => is {user.id}
    end
  end
end

privileges do
  privilege :manage do
    includes :index, :show, :new, :create, :edit, :update, :destroy
  end
end
