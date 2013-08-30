class FileUpload < ActiveRecord::Base
  
  belongs_to :line_item
  
  validates_attachment_presence :file
  
  has_attached_file :file, :url => '/file_uploads/:id/:style/:filename', :path => ':rails_root/assets/:url', :styles => {:thumb => '50x50'}
  
  before_post_process :is_image?
  
  def is_image?
    /image/ =~ file.content_type
  end
end
