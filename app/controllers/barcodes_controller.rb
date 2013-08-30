class BarcodesController < ApplicationController
  def show
    require 'barby/outputter/rmagick_outputter'
    barcode = Barby::Code39.new "*#{params[:number]}*", true
    send_data barcode.to_gif(:height => 50), :content_type => 'image/gif', :disposition => 'inline'
  rescue
    render :text => 'Barcode could not be generated.'
  end
end
