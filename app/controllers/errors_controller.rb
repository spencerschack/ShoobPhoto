class ErrorsController < ApplicationController
  def four_oh_four
    render '404', :status => 404, :formats => [:html]
  end
  
  def five_hundred
    render '500', :status => 500, :formats => [:html]
  end
end
