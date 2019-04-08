require 'rails_helper'

RSpec.describe FrontFile do
  describe '::entry_point' do
    it 'returns `front` SPA entry point (index.html)' do
      front_file = FrontFile.entry_point

      expect(front_file.path).to eq('index.html')
    end
  end

  describe '#filename' do
    it 'returns filename' do
      front_file = FrontFile.new(filename: 'index', format: 'html')

      expect(front_file.filename).to eq('index')
    end

    context 'when format is blank?' do
      it 'returns empty string' do
        front_file = FrontFile.new(filename: nil, format: 'html')

        expect(front_file.filename).to eq('')
      end
    end
  end

  describe '#format' do
    it 'returns format' do
      front_file = FrontFile.new(filename: 'index', format: 'html')

      expect(front_file.format).to eq('html')
    end

    context 'when format is blank?' do
      it 'returns empty string' do
        front_file = FrontFile.new(filename: 'index', format: nil)

        expect(front_file.format).to eq('')
      end
    end
  end

  describe '#valid?' do
    context 'when front file exists' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'favicon', format: 'ico')

        expect(front_file.valid?).to be_truthy
      end
    end

    context 'when front file does NOT exist' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'main', format: 'html')

        expect(front_file.valid?).to be_falsey
      end
    end
  end

  describe '#has_possible_filename?' do
    context 'when filename is blank' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '', format: 'js')

        expect(front_file.has_possible_filename?).to be_falsey
      end
    end

    context 'when filename is present' do
      context 'when filename includes ".."' do
        it 'returns falsey value' do
          front_file = FrontFile.new(filename: '../../.ssh/id_rsa', format: 'pub')

          expect(front_file.has_possible_filename?).to be_falsey
        end
      end

      context 'when filename exludes ".."' do
        it 'returns truthy value' do
          front_file = FrontFile.new(filename: 'index', format: 'html')

          expect(front_file.has_possible_filename?).to be_truthy
        end
      end
    end
  end

  describe '#has_allowed_format?' do
    context 'and format is NOT "html", "css", "js", "json", "ico", or "png"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'index', format: 'map')

        expect(front_file.has_allowed_format?).to be_falsey
      end
    end

    context 'when format is "html", "css", "js", "json", "ico" or "png"' do
      it 'returns truthy value' do
        expect(FrontFile.new(filename: 'index', format: 'html').has_allowed_format?).to be_truthy
        expect(FrontFile.new(filename: 'index', format: 'css').has_allowed_format?).to be_truthy
        expect(FrontFile.new(filename: 'index', format: 'js').has_allowed_format?).to be_truthy
        expect(FrontFile.new(filename: 'index', format: 'json').has_allowed_format?).to be_truthy
        expect(FrontFile.new(filename: 'index', format: 'ico').has_allowed_format?).to be_truthy
        expect(FrontFile.new(filename: 'index', format: 'png').has_allowed_format?).to be_truthy
      end
    end

    context 'when format is map' do
      context 'and source maps are allowed' do
        it 'returns truthy value' do
          expect(FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk.css', format: 'map', allow_source_maps: true).has_allowed_format?).to be_truthy
        end
      end

      context 'and source maps are NOT allowed' do
        it 'returns falsey value' do
          expect(FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk.css', format: 'map').has_allowed_format?).to be_falsey
        end
      end
    end
  end

  describe '#exist?' do
    context 'when front file does NOT have possible filename' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '../../.ssh/id_rsa', format: 'pub')

        expect(front_file.exist?).to be_falsey
      end
    end

    context 'when front file does NOT have allowed format' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'experiences', format: '')

        expect(front_file.exist?).to be_falsey
      end
    end

    context 'when front file has possible filename and allowed format' do
      context 'when file with path exists in OS' do
        it 'returns truthy value' do
          front_file = FrontFile.new(filename: 'index', format: 'html')

          expect(front_file.exist?).to be_truthy
        end
      end

      context 'when file with path does not exist in OS' do
        it 'returns falsey value' do
          front_file = FrontFile.new(filename: 'main', format: 'html')

          expect(front_file.exist?).to be_falsey
        end
      end
    end
  end

  describe '#path' do
    context 'when front file does NOT have possible filename' do
      it 'returns empty string' do
        front_file = FrontFile.new(filename: '', format: 'css')

        expect(front_file.path).to eq('')
      end
    end

    context 'when front file has NOT allowed format' do
      it 'returns empty string' do
        front_file = FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk', format: '')

        expect(front_file.path).to eq('')
      end
    end

    it 'returns path as filename and format joined by dot' do
      front_file = FrontFile.new(filename: 'index', format: 'html')

      expect(front_file.path).to eq('index.html')
    end
  end

  describe '#absolute_path' do
    context 'when front file has NOT possible filename' do
      it 'returns empty string' do
        front_file = FrontFile.new(filename: '', format: 'css')

        expect(front_file.absolute_path).to eq('')
      end
    end

    context 'when front file has NOT allowed format' do
      it 'returns empty string' do
        front_file = FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk', format: '')

        expect(front_file.absolute_path).to eq('')
      end
    end

    it 'returns absolute path as `core` root + `/public/build` + path' do
      front_file = FrontFile.new(filename: 'index', format: 'html')

      expect(front_file.absolute_path).to eq(Rails.root.join('public/build/index.html').to_s)
    end
  end

  describe '#content_type' do
    context 'when front file has NOT allowed format' do
      it 'returns empty string' do
        front_file = FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk', format: '')

        expect(front_file.content_type).to eq('')
      end
    end

    context 'when front file format is valid Mime Type extension' do
      it 'returns content type' do
        front_file = FrontFile.new(filename: 'index', format: 'html')

        expect(front_file.content_type).to eq('text/html')
      end
    end

    context 'when front file format is NOT valid Mime Type extension' do
      it 'returns empty string' do
        front_file = FrontFile.new(filename: 'index', format: 'hello')

        expect(front_file.content_type).to eq('')
      end
    end

    context 'when front file format is "map"' do
      it 'returns "application/json"' do
        front_file = FrontFile.new(filename: 'static/js/2.2f5d7006.chunk.js', format: 'map', allow_source_maps: true)

        expect(front_file.content_type).to eq('application/json')
      end
    end
  end
end
