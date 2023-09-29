require 'rubygems'
require 'RMagick'

class ImageConvertersController < ApplicationController


  def update_format
    img_format = params[:img_format]
    img = Magick::Image.read(params[:image].tempfile.path)[0]
    image_bytes = img.to_blob { |attrs| attrs.format = img_format }
    send_data(image_bytes, :type => "image/#{img_format}")
  end

end
