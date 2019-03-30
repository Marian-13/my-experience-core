class FrontFile
  def initialize(filename:, format:)
    @filename = filename
    @format   = format
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
    entry_point? || favicon? || css_file? || js_file?
  end

  def entry_point?
    path == 'index.html'
  end

  def favicon?
    path == 'favicon.ico'
  end

  def css_file?
    has_possible_filename? && filename.start_with?('static/css/') && format == 'css'
  end

  def js_file?
    has_possible_filename? && filename.start_with?('static/js/') && format == 'js'
  end

  def has_possible_filename?
    filename.present? && filename.exclude?('..')
  end

  def has_allowed_format?
    format.in?(['html', 'css', 'js', 'ico'])
  end

  def exist?
    return false if !has_possible_filename? || !has_allowed_format?

    File.exist?(absolute_path)
  end

  def path
    return '' if !has_possible_filename? || !has_allowed_format?

    "#{filename}.#{format}"
  end

  def absolute_path
    return '' if !has_possible_filename? || !has_allowed_format?

    Rails.root.join('public', 'build', path).to_s
  end
end
