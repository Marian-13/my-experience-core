class ApplicationController < ActionController::Base
  # GET '/'
  def index
    render component: 'App', locals: { app_name: 'front' }
  end
end
