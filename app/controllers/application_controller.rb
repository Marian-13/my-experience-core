class ApplicationController < ActionController::Base
  def index
    app_name = current_user_is_logged_in? ? 'front' : 'landing'

    render component: "#{app_name}/App", locals: { app_name: app_name }
  end

  private

  def current_user_is_logged_in?
    false
  end
end
