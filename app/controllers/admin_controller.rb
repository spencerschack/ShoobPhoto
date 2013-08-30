class AdminController < ApplicationController
  filter_access_to :all
  def index
  end
  
  def help
  end
  
  def log
    @production_messages = IO.read("#{Rails.root}/log/production.log").split(/\n\n/).reverse
    @development_messages = IO.read("#{Rails.root}/log/development.log").split(/\n\n/).reverse
  end

end
