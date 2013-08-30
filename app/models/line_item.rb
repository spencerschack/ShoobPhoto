class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order
  has_one :file_upload, :dependent => :destroy
  
  serialize :data
end
