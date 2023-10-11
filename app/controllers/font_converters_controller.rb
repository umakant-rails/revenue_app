require 'rubyXL'
require 'docx'

class FontConvertersController < ApplicationController
  
  # GET /font_converters/new
  def new
    @conversion_type = params[:conversion_type].blank? ? "kruti-to-mangal" : params[:conversion_type]
  end

  def export_docx
    content_text = params[:mangaltext].present? ? params[:mangaltext] : params[:krutitext]
    file_name = params[:mangaltext].present? ? 'file_mangal.docx' : 'file_krutidev.docx'

    respond_to do |format|
      # format.html { redirect_to new_font_converter_url, notice: "" }
      format.docx do
        render docx: file_name, inline: content_text
      end
    end
  end

  def image_to_pdf
    respond_to do |format|
      format.pdf do
        render pdf: "#{params[:chart_name]}.pdf",
          inline: "<center><h1>#{params[:chart_name] == 'krutidev' ? 'Kruti Dev' : 'Unicode (Inscript)'} Font Chart</h1></center><br/><center>
          <img src='#{Rails.root.to_s + '/app/assets/images/'+params[:chart_name]+'.png'}'/></center>",
          orientation: 'Landscape',
          page_size: 'A4'
      end
    end
  end

  def convert_docs
    obj_font_converter = FontConvertor.new

    if params[:conversion_type].present? && params[:docs_type] == "docx"
      file_name = params[:docs].original_filename
      file_name = file_name[0, file_name.index('.')]
      file_path = params[:docs].tempfile.path 
      
      docs = Docx::Document.open(file_path) rescue nil

      if docs.present? && params[:conversion_type] == "Kruti to Mangal(Unicode)"
        docs_translated = obj_font_converter.convert_docs_kruti_to_unicode(docs)
        docs_translated.save("/tmp/#{file_name}-mangal.docx")
        send_data docs, filename: "#{file_name}-mangal.docx", disposition: "downloaded"
      elsif docs.present? && params[:conversion_type] == "Mangal(Unicode) To Kruti"
        docs_translated = obj_font_converter.convert_docs_unicode_to_kruti(docs)
        docs_translated.save("#{file_name}-kruti.docx")
        send_data docs_translated, filename: "#{file_name}-kruti.docx", disposition: 'downloaded'
      else
        respond_to do |format|
          flash[:error] = "There is something wrong with your docx file. May be docx file is not in proper format."
          format.html { redirect_to new_docs_convert_font_converters_path }
        end
      end

    elsif params[:conversion_type].present? && params[:docs_type] == "xlsx"
      if params[:conversion_type] == "Kruti to Mangal(Unicode)"
      else
      end
    else

    end
  end


  def kruti_to_unicode
    #https://www.codehim.com/vanilla-javascript/javascript-crop-image-and-save/
  end

  def unicode_to_mangal
    #https://www.codehim.com/vanilla-javascript/javascript-crop-image-and-save/
  end

end
