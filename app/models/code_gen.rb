class CodeGen
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :student_id, :school_id
  
  validates_presence_of :student_id, :school_id
  
  def initialize(attrs = {})
    attrs.each do |key,value|
      send("#{key}=", value)
    end
  end
  
  def persisted?
    false
  end
  
  def code
    Proof.encode("#{student_id}-#{school_id}")
  end
end