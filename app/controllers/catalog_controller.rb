class CatalogController < ApplicationController
  
  def schools
    unless params[:search].blank?
      @results = School.where('title LIKE ?', "%#{params[:search]}%")
    end
    @school_types = SchoolType.all
  end

  def package_types
    @school = School.find_by_slug params[:school]
    @package_types = @school.package_types
  end

  def packages
    @school = School.find_by_slug params[:school]
    @package_type = @school.package_types.find_by_slug params[:package_type]
    @packages = @package_type.packages.order(:title)
  rescue
    raise ActiveRecord::RecordNotFound
  end

  def package
    @cart_package = CartPackage.new(
      :school => @school = School.find_by_slug(params[:school]),
      :package => @school.package_types.find_by_slug(params[:package_type]).packages.find_by_slug(params[:package])
    )
  end
  
  def senior_warning
  end
  
  def printing
    @products = Product.all
  end
  
  def printing_product
    @cart_product = CartProduct.new(
      :product => Product.find_by_slug(params[:product])
    )
  end

end
