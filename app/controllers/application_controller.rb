class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, with: :permission_denied unless ["development"].include?(Rails.env)
  rescue_from ActiveRecord::RecordNotFound, with: :routing_error unless ["development"].include?(Rails.env)
  rescue_from ActionView::Template::Error, with: :routing_error unless ["development"].include?(Rails.env)

  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end

  def permission_denied(exception)
    respond_to do |format|
      format.html{ render :file => "#{Rails.root}/public/permission_denied.html.erb", :status => 404 }
    end
  end

  def routing_error(exception=nil)
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
