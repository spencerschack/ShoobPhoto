class OptionTypesController < ApplicationController
  filter_resource_access
  # GET /option_types
  # GET /option_types.xml
  def index
    @option_types = OptionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @option_types }
    end
  end

  # GET /option_types/1
  # GET /option_types/1.xml
  def show
    @option_type = OptionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @option_type }
    end
  end

  # GET /option_types/new
  # GET /option_types/new.xml
  def new
    @option_type = OptionType.new
    3.times{ @option_type.option_assignments.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @option_type }
    end
  end

  # GET /option_types/1/edit
  def edit
    @option_type = OptionType.find(params[:id])
    3.times{ @option_type.option_assignments.build }
  end

  # POST /option_types
  # POST /option_types.xml
  def create
    @option_type = OptionType.new(params[:option_type])

    respond_to do |format|
      if @option_type.save
        format.html { redirect_to(@option_type, :notice => 'Option type was successfully created.') }
        format.xml  { render :xml => @option_type, :status => :created, :location => @option_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @option_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /option_types/1
  # PUT /option_types/1.xml
  def update
    @option_type = OptionType.find(params[:id])

    respond_to do |format|
      if @option_type.update_attributes(params[:option_type])
        format.html { redirect_to(@option_type, :notice => 'Option type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @option_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /option_types/1
  # DELETE /option_types/1.xml
  def destroy
    @option_type = OptionType.find(params[:id])
    @option_type.destroy

    respond_to do |format|
      format.html { redirect_to(option_types_url) }
      format.xml  { head :ok }
    end
  end
end
