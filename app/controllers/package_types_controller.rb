class PackageTypesController < ApplicationController
  filter_resource_access
  # GET /package_types
  # GET /package_types.xml
  def index
    @package_types = PackageType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @package_types }
    end
  end

  # GET /package_types/1
  # GET /package_types/1.xml
  def show
    @package_type = PackageType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @package_type }
    end
  end

  # GET /package_types/new
  # GET /package_types/new.xml
  def new
    @package_type = PackageType.new
    3.times do
      @package_type.prices.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @package_type }
    end
  end

  # GET /package_types/1/edit
  def edit
    @package_type = PackageType.find(params[:id])
    3.times do
      @package_type.prices.build
    end
  end

  # POST /package_types
  # POST /package_types.xml
  def create
    @package_type = PackageType.new(params[:package_type])

    respond_to do |format|
      if @package_type.save
        format.html { redirect_to(@package_type, :notice => 'Package type was successfully created.') }
        format.xml  { render :xml => @package_type, :status => :created, :location => @package_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @package_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /package_types/1
  # PUT /package_types/1.xml
  def update
    @package_type = PackageType.find(params[:id])
    params[:package_type][:school_ids] ||= []
    params[:package_type][:package_ids] ||= []

    respond_to do |format|
      if @package_type.update_attributes(params[:package_type])
        format.html { redirect_to(@package_type, :notice => 'Package type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @package_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /package_types/1
  # DELETE /package_types/1.xml
  def destroy
    @package_type = PackageType.find(params[:id])
    @package_type.destroy

    respond_to do |format|
      format.html { redirect_to(package_types_url) }
      format.xml  { head :ok }
    end
  end
end
