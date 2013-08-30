class PackageType < ActiveRecord::Base
  has_many :packages
  has_and_belongs_to_many :schools
  has_many :prices, :dependent => :destroy
  
  before_validation :set_slug
  
  validates_presence_of :title

  accepts_nested_attributes_for :prices, :reject_if => proc {|attrs| attrs['price'].blank?}, :allow_destroy => true
  
  has_attached_file :image, :url => '/images/package_types/:id/:filename'
    
  def slug= slug_value
    write_attribute :slug, slug_value.parameterize('_')
  end

  def price school = nil
    prices.where('school_id = ? OR school_id IS NULL', school).where('end > ? OR end IS NULL', Time.now).where('begin < ? OR begin IS NULL', Time.now).order('school_id DESC, end DESC, begin DESC').first.price rescue 0
  end
  
  private
  
  def set_slug
    write_attribute :slug, title.parameterize('_') if slug.blank?
  end
end
