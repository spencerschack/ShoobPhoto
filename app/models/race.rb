class Race < ActiveRecord::Base
  has_many :results
  has_many :runners, :through => :results
end
