class Price < ActiveRecord::Base
  belongs_to :school
  belongs_to :package
  belongs_to :option
  belongs_to :package_type
end
