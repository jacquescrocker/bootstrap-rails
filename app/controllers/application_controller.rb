class ApplicationController < ActionController::Base
  extend ActiveSupport::Memoizable
  include Backend::ErrorHandlers

  protect_from_forgery

  protected

  helper_method :logged_in?
  def logged_in?
    current_user.present?
  end

  helper_method :current_user
  def current_user
    # TODO: implement this
    nil
  end

  def current_user=(user)
    # TODO: implement this
    nil
  end

  before_filter :force_domain
  def force_domain
    return true unless Settings.force_domain
    return true if request.xhr?
    return true if Rails.env.test?

    # check if we're on the right domain, if not redirect
    redirect_url = Bootstrap::Routing::ForceDomain.new(Settings.force_domain).redirect?(request)

    if redirect_url.blank?
      return true
    else
      redirect_to(redirect_url)
      return false
    end
  end

  before_filter :set_user_time_zone
  def set_user_time_zone
    # if logged_in?
    #   Time.zone = current_user.time_zone if current_user.time_zone.present?
    # end
    return true
  end

  # redirects to the params[:return_url] value, otherwise use the url argument
  def return_or_redirect_to(default_url)
    flash.keep
    if params[:return_url].present?
      redirect_to params[:return_url]
    else
      redirect_to default_url
    end
  end

  # check to see if we should use mobile optimized views
  def mobile?
    if params[:force_mobile] == "true"
      cookies["force_mobile"] = "true"
    elsif params[:force_mobile] == "false"
      cookies["force_mobile"] = nil
    end

    cookies["force_mobile"] || (!!env[Rack::MobileDetect::X_HEADER] && request.headers['HTTP_USER_AGENT'] !~ /ipad/i)
  end

end
