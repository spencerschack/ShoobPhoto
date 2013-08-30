class School < ActiveRecord::Base
  belongs_to :school_type
  has_many :proofs
  has_and_belongs_to_many :package_types
  has_many :prices, :dependent => :destroy
  has_many :option_assignments, :dependent => :destroy
  
  before_validation :set_slug
  
  validates_presence_of :title, :school_type
  validates_uniqueness_of :slug
  
  default_scope order :title
  
  def slug= slug_value
    write_attribute :slug, slug_value.parameterize('_')
  end
  
  private
  
  def set_slug
    write_attribute :slug, title.parameterize('_') if slug.blank?
  end
end