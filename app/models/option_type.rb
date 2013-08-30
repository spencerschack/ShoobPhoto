class OptionType < ActiveRecord::Base
  has_many :option_assignments
  has_many :packages, :through => :option_assignments
  has_many :options, :dependent => :destroy
  
  validates_presence_of :title
  
  accepts_nested_attributes_for :option_assignments, :reject_if => proc {|attrs| attrs['package_id'].blank?}, :allow_destroy => true
end
