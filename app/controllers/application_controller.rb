class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_https

  def redirect_https
    redirect_to :protocol => "https://" unless request.ssl?
    return true
  end

end
