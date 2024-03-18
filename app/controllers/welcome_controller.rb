class WelcomeController < ApplicationController
  def index
    get_blank_forms
    @categories = BlankForm.all.pluck(:section_hindi).uniq
  end

  def form_index
    get_blank_forms
  end

  def autocomplete_term
    search_term = params[:q].strip
    search_term = search_term.downcase if search_term.present?
    @blank_forms = BlankForm.where("Lower(eng_name) like ?", "%#{search_term}%")

    respond_to do |format|
      format.html {}
      format.json { head :no_content }
    end
    render layout: false
  end

  def form_search
    form_id = params[:form_id]
    search_term = params[:search_term].strip if form_id.blank?
    queryy = ''

    if form_id.present?
      queryy = "id=#{form_id}"
    elsif search_term.present?
      queryy = "LOWER(eng_name) like '%#{search_term}%'"
    end
    @blank_forms = BlankForm.where(queryy).page(params[:page]).per(8) rescue nil

    respond_to do |format|
      format.html {}
      format.js {}
    end
    render layout: false
  end

  private

  def get_blank_forms
    @districts = Village.all.pluck(:district).uniq
    @blank_forms = BlankForm.all.page(params[:page]).per(10) rescue nil
  end

end
