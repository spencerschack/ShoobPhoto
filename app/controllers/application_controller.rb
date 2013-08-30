class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from ActiveRecord::RecordNotFound, ActionController::UnknownController, ActionController::UnknownAction, :with => :not_found_error
  rescue_from StandardError, :with => :server_error
  
  helper_method :current_user_session, :current_user
  before_filter :set_current_user, :set_asset_vars, :set_nav_links

  include SslRequirement
  
  private
  
  def server_error exc
    logger.debug "[500] #{exc.inspect}"
    logger.debug exc.backtrace.join("\n")
    render 'errors/500', :status => 500, :formats => [:html]
  end
  
  def not_found_error exc
    logger.debug "[404] #{exc.inspect}"
    render 'errors/404', :status => 404, :formats => [:html]
  end

  def current_user_session
    return @current_user_session if defined? @current_user_session
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end
  
  def set_nav_links
    @nav_links = NavLink.order(:position).roots
  end
  
  def set_asset_vars
  	@stylesheets = ['application/base']
  	@stylesheets_print = []
  	@javascripts = ['application/jquery','application/base']
  end

  def set_current_user
    Authorization.current_user = current_user
  end

  def permission_denied
    flash[:error] = 'Sorry, you are not allowed to access that page.'
    redirect_to root_url
  end

end
