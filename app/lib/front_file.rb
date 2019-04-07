class FrontFile
  PUBLIC_FOLDER = Dir.chdir(Rails.root.join('public', 'build')) do
    Dir.glob('**/*').select { |entry| File.file?(entry) }
  end

  def initialize(filename:, format:, allow_source_maps: false)
    @filename = filename
    @format   = format

    @allow_source_maps = allow_source_maps
  end

  def self.entry_point
    new(filename: 'index', format: 'html')
  end

  def filename
    @filename || ''
  end

  def format
    @format || ''
  end

  def valid?
    possible? && exist?
  end

  def possible?
    entry_point? || favicon? || manifest? || css_file? || js_file? || png_file? ||
      (source_maps_allowed? && (css_map_file? || js_map_file?))
  end

  def entry_point?
    path == 'index.html'
  end

  def favicon?
    path == 'favicon.ico'
  end

  def manifest?
    path == 'manifest.json'
  end

  def css_file?
    has_possible_filename? && filename.start_with?('static/css/') && format == 'css'
  end

  def js_file?
    has_possible_filename? && filename.start_with?('static/js/') && format == 'js'
  end

  def css_map_file?
    has_possible_filename? && filename.start_with?('static/css/') && filename.end_with?('css') && format == 'map'
  end

  def js_map_file?
    has_possible_filename? && filename.start_with?('static/js/') && filename.end_with?('js') && format == 'map'
  end

  def png_file?
    has_possible_filename? && filename.start_with?('static/media/') && format == 'png'
  end

  def has_possible_filename?
    filename.present? && filename.exclude?('..')
  end

  def has_allowed_format?
    format.in?(['html', 'css', 'js', 'json', 'ico', 'png']) || (source_maps_allowed? && format == 'map')
  end

  def exist?
    return false if !has_possible_filename? || !has_allowed_format?

    PUBLIC_FOLDER.include?(path)
  end

  def path
    return '' if !has_possible_filename? || !has_allowed_format?

    "#{filename}.#{format}"
  end

  def absolute_path
    return '' if !has_possible_filename? || !has_allowed_format?

    Rails.root.join('public', 'build', path).to_s
  end

  private

  def source_maps_allowed?
    @allow_source_maps
  end
end
