# HACK Due to nesting using scope resolution operator, Rails does not autoload Knock::Authenticable
# https://github.com/nsarno/knock/blob/master/lib/knock/authenticable.rb
require "#{Gem.loaded_specs['knock'].full_gem_path}/lib/knock/authenticable"

class ApplicationController < ActionController::Base
  include Knock::Authenticable

  # GET '/'
  def index
    app_name = current_user ? 'front' : 'landing'

    render component: "#{app_name}/App", locals: { app_name: app_name }
  end
end
