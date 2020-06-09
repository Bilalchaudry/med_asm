class HomeController < ApplicationController
  def page_content
    if params[:page_type].present?
      @page_content = Content.where(page_type: params[:page_type]).first
    else
      error_response("Missing required parameters")
    end
  end

end
