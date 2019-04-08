class ApplicationController < ActionController::API
  # GET '/'
  def root
    render_front_file(FrontFile.entry_point)
  end

  # GET '/*filename.:format'
  def public
    return render_front_file(FrontFile.entry_point) if params[:format].blank?
    return render_front_file(FrontFile.entry_point) if params[:format] == 'html'

    front_file = FrontFile.new(filename: params[:filename], format: params[:format], allow_source_maps: true)

    return render_not_found unless front_file.valid?

    render_front_file(front_file)
  end

  private

  def render_front_file(front_file)
    send_file front_file.absolute_path, type: front_file.content_type, disposition: 'inline'
  end

  def render_not_found
    render status: :not_found, body: nil
  end
end
