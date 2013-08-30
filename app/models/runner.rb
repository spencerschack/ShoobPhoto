class Runner < ActiveRecord::Base
  has_many :results, :dependent => :destroy
  has_many :races, :through => :results
  
  accepts_nested_attributes_for :results, :reject_if => proc {|attrs| attrs['distance'].blank?}, :allow_destroy => true
  
  def name
    "#{first_name} #{last_name}"
  end
end
