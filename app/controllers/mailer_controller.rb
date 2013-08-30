class MailerController < ApplicationController
  filter_access_to :index, :deliver
  
  def index
    @mailer = Mailer.new(params[:mailer])
  end
  
  def deliver
    if ContactMailer.mass_email(params[:mailer]).deliver
      render :text => 'Batch sent!'
    else
      render :text => 'Error', :status => 502
    end
  end
end
