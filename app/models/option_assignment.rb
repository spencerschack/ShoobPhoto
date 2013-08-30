class OptionAssignment < ActiveRecord::Base
  belongs_to :option_type
  belongs_to :package
  belongs_to :school
end
