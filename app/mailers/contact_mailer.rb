class ContactMailer < ActionMailer::Base

  def contact_form args
    @name = args[:name]
    @school = args[:school]
    @email = args[:email]
    @phone = args[:phone]
    @interests = args[:interests].keys.to_sentence if args[:interests].is_a?(Hash)
    @message = args[:message]
    mail :to => 'alex@shoobphoto.com', :from => "#{@name} <#{@email}>", :subject => "#{@name} sent a message from ShoobPhoto.com"
  end

  def job_application args
    @args = args
    mail :to => 'info@shoobphoto.com', :from => "#{args[:first_name]} #{args[:last_name]} <#{args[:email]}>", :subject => "#{args[:first_name]} #{args[:last_name]} submitted a job application from ShoobPhoto.com"
  end
  
  def file_download args
    @name = args[:name]
    @email = args[:email]
    @phone = args[:phone]
    @school = args[:school]
    @file = args[:file]
    mail :to => 'info.s@shoobphoto.com', :from => 'info@shoobphoto.com', :subject => "#{args[:name]} has downloaded a file from ShoobPhoto.com"
  end
  
  def mass_email args
    @message = args[:message]
    args[:addresses][0,99].each do |address|
      mail :to => address, :from => 'info@shoobphoto.com', :subject => args[:subject]
    end
  end
end
