class NavLink < ActiveRecord::Base
  acts_as_nested_set
    
  before_validation :set_slug
  
  validates_presence_of :title
  
  def slug= slug_value
    write_attribute :slug, slug_value.parameterize('_')
  end
  
  def path
    "/#{self_and_ancestors.map(&:slug).join('/')}"
  end
  
  private
  
  def set_slug
    write_attribute :slug, title.parameterize('_') if slug.blank?
  end
end
