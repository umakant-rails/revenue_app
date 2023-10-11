require 'rubygems'
require 'RMagick'

class ImageConvertersController < ApplicationController

  def index 
  
  end

  def update_format
    img_format = params[:img_format]
    if img_format.present? 
      img = Magick::Image.read(params[:image].tempfile.path)[0]
      image_bytes = img.to_blob { |attrs| attrs.format = img_format }
      send_data(image_bytes, :type => "image/#{img_format}")
    else
      flash[:error] = "Please Select format to convert image."
      respond_to do | format | 
        format.html { redirect_back_or_to edit_format_image_converters_path }
      end
    end 
  end

end
