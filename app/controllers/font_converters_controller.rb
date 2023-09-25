class FontConvertersController < ApplicationController
  
  # GET /font_converters/new
  def new
    @conversion_type = params[:conversion_type].blank? ? "kruti-to-mangal" : params[:conversion_type]
  end

  def export_docx
    content_text = params[:mangaltext].present? ? params[:mangaltext] : params[:krutitext]
    file_name = params[:mangaltext].present? ? 'file_mangal' : 'file_krutidev'

    respond_to do |format|
      format.html { redirect_to new_font_converter_url, notice: "" }
      format.docx do
        render docx: file_name, content: content_text
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

end
