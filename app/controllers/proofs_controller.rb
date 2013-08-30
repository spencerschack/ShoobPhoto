class ProofsController < ApplicationController
  before_filter :convert_code_to_id
  
  filter_access_to :all
  
  def index
    @proofs = Proof.all
  end

  # GET /proofs/1
  # GET /proofs/1.xml
  def show
    @proof = Proof.find(params[:id])
  end

  # GET /proofs/new
  # GET /proofs/new.xml
  def new
    @proof = Proof.new
  end

  # GET /proofs/1/edit
  def edit
    @proof = Proof.find(params[:id])
  end

  # POST /proofs
  # POST /proofs.xml
  def create
    photo_params = params[:proof].delete(:photos)
    @proof = Proof.new(params[:proof])
    
    if @proof.save
      photo_params.each do |photo|
        @proof.proof_images.create.update_attributes(:image => photo)
      end
    
      if @proof.save
        redirect_to "/proof/#{@proof.code}", :notice => 'Proof was successfully created.'
      else
        render :action => 'new'
      end
      
    else
      render :action => 'edit'
    end
  end

  # PUT /proofs/1
  # PUT /proofs/1.xml
  def update
    photo_params = params[:proof].delete(:photos)
    @proof = Proof.find(params[:id])

    if @proof.update_attributes(params[:proof])
      
      photo_params.each do |photo|
        @proof.proof_images.create.update_attributes(:image => photo)
      end
      
      if @proof.save
        redirect_to "/proof/#{@proof.code}", :notice => 'Proof was successfully updated.'
      else
        render :action => 'edit'
      end
      
    else
      render :action => 'edit'
    end
  end

  # DELETE /proofs/1
  # DELETE /proofs/1.xml
  def destroy
    @proof = Proof.find(params[:id])
    @proof.destroy

    redirect_to proofs_url
  end
  
  def generate_code
    @code_gen = params[:code_gen].blank? ? CodeGen.new : CodeGen.new(params[:code_gen])
  end
  
  private
  
  def convert_code_to_id
    params[:id] = Proof.find_by_code(params[:code]).id if params[:code].present?
  rescue
    raise ActiveRecord::RecordNotFound
  end
end
