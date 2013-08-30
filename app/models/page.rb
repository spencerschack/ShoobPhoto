class Page < ActiveRecord::Base
  
  cattr_accessor :paths
  
  acts_as_nested_set
  
  before_validation :set_slug
  
  after_save :update_paths_cache
  
  def slug= slug_value
    write_attribute :slug, slug_value.parameterize('_')
  end
  
  def path
  	"/#{self_and_ancestors.map(&:slug).join('/')}"
  end
  
  def self.paths
    @@paths ||= all.map(&:path)
  end
  
  private
  
  def set_slug
    write_attribute :slug, title.parameterize('_') if slug.blank?
  end
  
  def update_paths_cache
    @@paths = Page.all.map(&:path)
  end
end
