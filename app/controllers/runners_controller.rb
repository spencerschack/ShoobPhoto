class RunnersController < ApplicationController
  filter_access_to :all
  
  # GET /runners
  # GET /runners.xml
  def index
    @runners = Runner.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @runners }
    end
  end

  # GET /runners/1
  # GET /runners/1.xml
  def show
    @runner = Runner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @runner }
    end
  end

  # GET /runners/new
  # GET /runners/new.xml
  def new
    @runner = Runner.new
    3.times do
      @runner.results.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @runner }
    end
  end

  # GET /runners/1/edit
  def edit
    @runner = Runner.find(params[:id])
    3.times do
      @runner.results.build
    end
  end

  # POST /runners
  # POST /runners.xml
  def create
    @runner = Runner.new(params[:runner])

    respond_to do |format|
      if @runner.save
        format.html { redirect_to(@runner, :notice => 'Runner was successfully created.') }
        format.xml  { render :xml => @runner, :status => :created, :location => @runner }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @runner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /runners/1
  # PUT /runners/1.xml
  def update
    @runner = Runner.find(params[:id])

    respond_to do |format|
      if @runner.update_attributes(params[:runner])
        format.html { redirect_to(@runner, :notice => 'Runner was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @runner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /runners/1
  # DELETE /runners/1.xml
  def destroy
    @runner = Runner.find(params[:id])
    @runner.destroy

    respond_to do |format|
      format.html { redirect_to(runners_url) }
      format.xml  { head :ok }
    end
  end
  
  def import
    if request.xhr? && params[:runner_import][:data]
      params[:runner_import][:columns].reject!{|k, v| v.blank?}
      data = params[:runner_import][:data].split(/\n/).reject(&:blank?)
      race_id = params[:runner_import].delete(:race_id)
      default_distance = params[:runner_import].delete(:distance)
      default_shadowchase = params[:runner_import].delete(:shadowchase)
      if !params[:runner_import][:columns].blank? && !data.blank?
        output = {:updated => [], :resolve => [], :imported => []}.with_indifferent_access
        columns = {}.with_indifferent_access
        params[:runner_import][:columns].each_pair do |index, column|
          columns[column.to_sym] = index.to_i
        end
        rows = []
        data.each do |row|
          row = row.split(/\t/)
          entry = {}.with_indifferent_access
          columns.each do |column, index|
            entry[column] = row[index]
          end
          rows << entry
        end
        rows.each do |row|
          result = nil
          distance = row.delete(:distance) || default_distance
          shadowchase = row.delete(:shadowchase) || default_shadowchase
          if (results = Runner.where(row.slice(:first_name, :last_name, :phone, :email))).any?
            result = results.first
            result.update_attributes(row.merge(:shadowchase => shadowchase))
            output[:updated] << results.first
          elsif (results = Runner.where(row.slice(:first_name, :last_name))).any?
            output[:resolve] << {:old => results.first.attributes.with_indifferent_access.except(:created_at, :updated_at, :id), :new => row.merge(:distance => distance, :race_id => race_id, :shadowchase => shadowchase), :id => results.first.id}
          else
            result = Runner.create(row.merge(:shadowchase => shadowchase))
            output[:imported] << result
          end
          unless result.nil?
            if distance.blank?
              result.results.find_or_create_by_race_id(race_id)
            else
              result.results.find_or_create_by_race_id_and_distance(race_id, distance)
            end
          end
        end
        ActiveRecord::Base.include_root_in_json = false
        render :json => output
      else
        render :text => 'Column assignments or data field is blank.', :status => 400
      end
    elsif request.xhr? && params[:runner_import][:resolve]
      race_id = params[:runner_import][:resolve].delete(:race_id)
      distance = params[:runner_import][:resolve].delete(:distance)
      result = nil
      if params[:runner_import][:resolve].delete(:new)
        result = Runner.create(params[:runner_import][:resolve])
      elsif params[:runner_import][:resolve].delete(:overwrite)
        result = Runner.find(params[:id])
        result.update_attributes(params[:runner_import][:resolve])
      end
      if distance.blank?
        result.results.find_or_create_by_race_id(race_id)
      else
        result.results.find_or_create_by_race_id_and_distance(race_id, distance)
      end
      render :nothing => true
    end
  end

end