class FieldAssignment < ActiveRecord::Base
  belongs_to :field
  belongs_to :package
  belongs_to :package_type
  belongs_to :school
end
