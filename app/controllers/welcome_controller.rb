class WelcomeController < ApplicationController
  def index
    @districts = Village.all.pluck(:district).uniq
    @blank_forms = BlankForm.all.page(params[:page]).per(8) rescue nil
  end
end
