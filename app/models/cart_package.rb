class CartPackage < ActiveRecord::Base
  belongs_to :school
  belongs_to :package
  has_and_belongs_to_many :options
  
  before_validation :sanitize_purchase_id, :if => 'purchase_id?'
  validates_presence_of :school_id, :package_id, :student_first_name, :student_last_name, :student_grade, :quantity
  validates_presence_of :student_teacher, :if => 'school.teacher'
  validates_presence_of :student_sport_level, :student_sport, :if => 'package.package_type.sport_level'
  validates_format_of :purchase_id, :with => /\d{3}[a-z]\d{6}/, :message => 'ID must be three numbers, followed by a letter, followed by six numbers', :if => 'package.purchase_id'
  validate :required_options
  
  # data returns a hash of line_item data that is stored in the data column
  # it is stored in a hash because the data varies between products and packages
  
  def data
    output = {
      :school => school.title,
      :package => package.title,
      :package_type => package.package_type.title,
      :quantity => quantity,
      :student_first_name => student_first_name,
      :student_last_name => student_last_name,
      :student_grade => student_grade,
    }
    output[:student_teacher] = student_teacher if school.teacher
    if package.package_type.sport_level
      output[:student_sport_level] = student_sport_level
      output[:student_sport] = student_sport
    end
    output[:purchase_id] = purchase_id if package.purchase_id
    output[:email_picture] = email_picture if package.email_picture
    if options.any?
      output[:options] = {}
      options.each do |option|
        output[:options][option.option_type.title] = option.title
      end
    end
    return output
  end
  
  # calculates the price of the package for the given school, adds it to the prices of all the options, and multiplies by the quantity
  
  def price
    price = package.price(school)
    price += options.map{|option| option.price(school)}.inject(:+) || 0
    price*=quantity
  end

  def shipping
    package.package_type.price(school)
  end
  
  private
  
  # sanitizes the purchase_id to ensure it properly matches the picture filename
  
  def sanitize_purchase_id
    purchase_id.downcase!
    purchase_id.gsub! /[^a-z0-9]/, ''
  end
  
  # iterates through each option and ensures the required options have values
  
  def required_options
    package.options(school.id).map(&:option_type).uniq.select(&:required).each do |option_type|
      errors.add :base, "#{option_type.title} must have a chosen value" unless options.map(&:option_type_id).include? option_type.id
    end
  end
end
