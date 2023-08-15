#require "rmagick"

class PdfsController < ApplicationController

  def image_to_pdf
  end

  def convert_image_to_pdf

    images = params[:files]
    pdf = Prawn::Document.new

    # Assuming the image is in params[:image], you can adjust this based on your setup
    # image_path = image.tempfile

    # pdf.image MiniMagick::Image.open(image_path), fit: [pdf.bounds.width, pdf.bounds.height]
    images && images.each do | key, file |
      pdf.image file.tempfile, fit: [pdf.bounds.width, pdf.bounds.height]
    end
    
    # pdf_file = Tempfile.new(['image_to_pdf', '.pdf'], Rails.root.join('tmp'))
    filename = "revenueforms_pdf_#{Time.now.to_i}.pdf"
    file_path = "#{Rails.root.join('tmp/image_to_pdf')}/#{filename}"
    pdf.render_file(file_path)
    #send_file(file_path, type: 'application/pdf', disposition: 'attachment' )

    respond_to do |format|
      if File.exist?(file_path) && File.extname(file_path).casecmp('.pdf') == 0
        pdf_size = '%.2f' % (File.size(file_path)/1024.0)

        format.js { render json: {file: filename, file_size: pdf_size + " KB"} }
      else
        puts "Something went gone wrong, please try again."
      end
    end
  end

  def download_file

  end

end
