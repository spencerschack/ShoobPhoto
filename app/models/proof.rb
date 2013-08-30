class Proof < ActiveRecord::Base
  belongs_to :school
  has_many :proof_images, :dependent => :destroy
  
  validates_presence_of :student_id, :school_id
  
  ENCODE = '9PY7JK5H2U4GXCAVNOFZTQWR60S8IBELDM13'
  
  DECODE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  
  def code
    Proof.encode("#{student_id}-#{school_id}")
  end
  
  class << self
    
    def find_by_code code
      find_by_student_id_and_school_id(*decode(code).split('-'))
    end
    
    # encode encrypts a string with a simple monoalphabetic cipher
    # dashes are ignored and all nonalphanumeric characters and dashes are stripped
    # the association between ENCODE and DECODE is also dependent on the position of the letter being replaced
    # this makes it more difficult to determine the codec
  
    def encode unencoded
      unencoded.upcase.gsub(/[^A-Z0-9-]/,'').split('').each_with_index.map do |(letter, index)|
        letter == '-' ? '-' : ((index = DECODE.index(letter)+index) >= ENCODE.length ? ENCODE[index-ENCODE.length].chr : ENCODE[index].chr)
      end.join
    end
    
    # decode simply does the opposite of what encode does
    
    def decode encoded
      encoded.split('').each_with_index.map do |(letter, index)|
        letter == '-' ? '-' : ((index = ENCODE.index(letter)-index) < 0 ? DECODE[index+DECODE.length].chr : DECODE[index].chr)
      end.join
    end
  
  end
end