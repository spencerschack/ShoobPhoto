class Product < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :slug
  
  has_attached_file :image, :url => '/images/products/:id/:filename'
  
  before_validation :set_slug
  
  def slug= slug_value
    write_attribute :slug, slug_value.parameterize('_')
  end
  
  private
  
  def set_slug
    write_attribute :slug, title.parameterize('_') if slug.blank?
  end
end
