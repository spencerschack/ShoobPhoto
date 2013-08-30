class JobApplication
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :first_name, :last_name, :phone, :email, :website, :address, :city, :state, :zip_code, :country
  attr_accessor :positions_applied_for, :desired_salary, :begin_date, :full_or_part_time, :monday_hours, :tuesday_hours, :wednesday_hours, :thursday_hours, :friday_hours, :saturday_hours, :sunday_hours
  attr_accessor :high_school, :years_of_high_school, :completion_date_of_high_school, :college, :years_of_college, :completion_date_of_college, :other_education, :years_of_other_education, :completion_date_of_other_education
  attr_accessor :accidents, :moving_violations, :crimes, :drivers_license, :drivers_license_state
  attr_accessor :first_employer_name, :first_supervisor_name, :first_employment_start_date, :first_employment_end_date, :first_employment_salary, :first_employment_address, :first_employment_city, :first_employment_state, :first_employment_zip_code, :first_employment_country, :first_employment_phone_number, :first_employment_job_title, :first_employment_reason_for_leaving, :first_employment_duties, :first_employment_contact
  attr_accessor :second_employer_name, :second_supervisor_name, :second_employment_start_date, :second_employment_end_date, :second_employment_salary, :second_employment_address, :second_employment_city, :second_employment_state, :second_employment_zip_code, :second_employment_country, :second_employment_phone_number, :second_employment_job_title, :second_employment_reason_for_leaving, :second_employment_duties, :second_employment_contact
  attr_accessor :third_employer_name, :third_supervisor_name, :third_employment_start_date, :third_employment_end_date, :third_employment_salary, :third_employment_address, :third_employment_city, :third_employment_state, :third_employment_zip_code, :third_employment_country, :third_employment_phone_number, :third_employment_job_title, :third_employment_reason_for_leaving, :third_employment_duties, :third_employment_contact
  attr_accessor :skills, :typing, :computer_platform, :programs
  attr_accessor :first_reference_name, :first_reference_position, :first_reference_company, :first_reference_phone
  attr_accessor :second_reference_name, :second_reference_position, :second_reference_company, :second_reference_phone
  attr_accessor :comments, :application_reasoning
  
  validates_presence_of :first_name, :last_name, :phone, :email, :address, :city, :state, :zip_code, :country, :application_reasoning
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of :phone, :minimum => 7
  
  validates_presence_of :desired_salary, :begin_date, :full_or_part_time, :monday_hours, :tuesday_hours, :wednesday_hours, :thursday_hours, :friday_hours, :saturday_hours, :sunday_hours
  validates_presence_of :first_reference_name, :first_reference_position, :first_reference_company, :first_reference_phone
  validates_presence_of :second_reference_name, :second_reference_position, :second_reference_company, :second_reference_phone

  def initialize(attrs = {})
    attrs.each do |key,value|
      send("#{key}=", value)
    end
  end
  
  def persisted?
    false
  end
end