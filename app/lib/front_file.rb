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
    exist?
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

  def content_type
    return '' unless has_allowed_format?

    return 'application/json' if format == 'map'

    Mime::Type.lookup_by_extension(format).to_s
  end

  private

  def source_maps_allowed?
    @allow_source_maps
  end
end
