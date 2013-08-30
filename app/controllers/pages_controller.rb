class PagesController < ApplicationController
  before_filter :set_params_id, :only => [:show, :edit, :update, :destroy]
  filter_resource_access

  def index
  end

  def show
    @page = Page.find(params[:id])
    @links = NavLink.roots.find_by_slug(@page.root.slug).try(:children)
    @stylesheets << ["pages/#{@page.slug}"] if File.exist?("#{Rails.root}/public/stylesheets/pages/#{@page.slug}.css")
    @javascripts << ["pages/#{@page.slug}"] if File.exist?("#{Rails.root}/public/javascripts/pages/#{@page.slug}.js")
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to @page, :notice => 'Page was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(params[:page])
      redirect_to @page, :notice => 'Page was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    redirect_to pages_url
  end

  private

  def set_params_id
    params[:id] ||= Page.find_by_slug(params[:page].split('/')[-1]).id
  end
end
