class ApplicationController < ActionController::API
  def root
    path = File.join(Rails.root, 'public', 'build', 'index.html')

    render file: path, content_type: 'text/html', layout: false
  end

  def public
    # /static/css/index.css
    # /filename________.format
    path = File.join(Rails.root, 'public', 'build', params[:filename])

    options = { file: path, layout: false }

    case params[:format]
    when 'css'
      options.merge!(content_type: 'text/css')
    when 'js'
      options.merge!(content_type: 'application/javascript')
    end

    render options
  end
end
