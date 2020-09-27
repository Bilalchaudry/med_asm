class HomeController < ApplicationController
  include ErrorMessage
  before_action :authenticate_user!
  def page_content
    if params[:page_type].present?
      @page_content = Content.where(page_type: params[:page_type]).first
      if @page_content.nil?
        bad_request_error "Page content not found", 404
      end
    else
      bad_request_error "Missing required parameters", 400
    end
  end

end
