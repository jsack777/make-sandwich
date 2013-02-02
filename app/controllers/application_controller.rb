class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_https

  def redirect_https
    return true unless Rails.env.match(/production/)
    redirect_to :protocol => "https://" unless request.ssl?
    true
  end

  before_filter :authenticate_user! unless Rails.env.match(/test/)
end
