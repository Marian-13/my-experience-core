class ApplicationController < ActionController::Base
  def index
    if current_user_is_logged_in?
      render component: 'Front', locals: { app_name: 'front' }
    else
      render component: 'Landing', locals: { app_name: 'landing' }
    end
  end

  private

  def current_user_is_logged_in?
    true
  end
end
