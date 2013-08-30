class ContactController < ApplicationController
  def message
    @message = Message.new
  end
  
  def send_message
    @message = Message.new params[:message]
    if @message.valid?
      ContactMailer.contact_form(params[:message]).deliver
      flash[:message] = 'Your message was sent.'
      redirect_to contact_url
    else
      render 'message'
    end
  end

  def job_application
    @job_application = JobApplication.new
  end
  
  def send_job_application
    @job_application = JobApplication.new params[:job_application]
    if @job_application.valid?
      ContactMailer.job_application(params[:job_application]).deliver
      flash[:message] = 'Your application was submitted.'
      redirect_to contact_url
    else
      render 'job_application'
    end
  end
  
  def file
    if File.exist? "#{Rails.root}/public/downloads/#{params[:file]}"
      @file = params[:file]
    else
      flash[:error] = 'File could not be found.'
      redirect_to root_url
    end
  end
  
  def file_download
    ContactMailer.file_download(params[:message].merge(:file => params[:file])).deliver
    redirect_to "/downloads/#{params[:file]}"
  end

end
