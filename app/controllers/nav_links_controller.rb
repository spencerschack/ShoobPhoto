class NavLinksController < ApplicationController
  filter_resource_access

  # GET /nav_links
  # GET /nav_links.xml
  def index
    @nav_links = NavLink.find(:all, :order => 'position ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nav_links }
    end
  end

  # GET /nav_links/1
  # GET /nav_links/1.xml
  def show
    @nav_link = NavLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nav_link }
    end
  end

  # GET /nav_links/new
  # GET /nav_links/new.xml
  def new
    @nav_link = NavLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nav_link }
    end
  end

  # GET /nav_links/1/edit
  def edit
    @nav_link = NavLink.find(params[:id])
  end

  # POST /nav_links
  # POST /nav_links.xml
  def create
    @nav_link = NavLink.new(params[:nav_link])

    respond_to do |format|
      if @nav_link.save
        format.html { redirect_to(@nav_link, :notice => 'Nav link was successfully created.') }
        format.xml  { render :xml => @nav_link, :status => :created, :location => @nav_link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nav_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nav_links/1
  # PUT /nav_links/1.xml
  def update
    @nav_link = NavLink.find(params[:id])

    respond_to do |format|
      if @nav_link.update_attributes(params[:nav_link])
        format.html { redirect_to(@nav_link, :notice => 'Nav link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nav_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nav_links/1
  # DELETE /nav_links/1.xml
  def destroy
    @nav_link = NavLink.find(params[:id])
    @nav_link.destroy

    respond_to do |format|
      format.html { redirect_to(nav_links_url) }
      format.xml  { head :ok }
    end
  end
end
