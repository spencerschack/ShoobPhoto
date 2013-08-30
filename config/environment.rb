# Load the rails application
require File.expand_path('../application', __FILE__)

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  "<span class='field_error'>#{html_tag}</span>".html_safe
end

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'shoobphoto.com',
  :authentication => 'plain',
  :user_name => 'info@shoobphoto.com',
  :password => 'can40d2011'
}

# Initialize the rails application
ShoobPhoto::Application.initialize!
