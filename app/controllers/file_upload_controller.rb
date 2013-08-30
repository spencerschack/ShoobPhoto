class FileUploadController < ApplicationController
  
  def show
    @image = FileUpload.find(params[:id])
    send_file @image.file.path(params[:style]), :type => @image.file_content_type, :disposition => 'inline'
  end
end
