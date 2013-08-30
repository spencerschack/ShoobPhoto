class SchoolType < ActiveRecord::Base
  has_many :schools
  
  validates_presence_of :title
end
