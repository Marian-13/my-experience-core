require 'rails_helper'

RSpec.describe FrontFile do
  describe '::entry_point' do
    it 'returns `front` SPA entry point (index.html)' do
      front_file = FrontFile.entry_point

      expect(front_file.entry_point?).to be_truthy
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
    context 'when front file is valid' do
      context 'and front file exists' do
        it 'returns truthy value' do
          front_file = FrontFile.new(filename: 'favicon', format: 'ico')

          expect(front_file.valid?).to be_truthy
        end
      end

      context 'and front file does NOT exist' do
        it 'returns falsey value' do
          front_file = FrontFile.new(filename: 'main', format: 'html')

          expect(front_file.valid?).to be_falsey
        end
      end
    end

    context 'when front file is NOT valid' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/js/2.2f5d7006.chunk.js', format: 'map')

        expect(front_file.valid?).to be_falsey
      end
    end
  end

  describe '#possible?' do
    context 'when front file is entry point, favicon, manifest, css file, js file or png file' do
      it 'returns truthy value' do
        expect(FrontFile.new(filename: 'index', format: 'html').possible?).to be_truthy
        expect(FrontFile.new(filename: 'favicon', format: 'ico').possible?).to be_truthy
        expect(FrontFile.new(filename: 'manifest', format: 'json').possible?).to be_truthy
        expect(FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk', format: 'css').possible?).to be_truthy
        expect(FrontFile.new(filename: 'static/js/2.2f5d7006.chunk', format: 'js').possible?).to be_truthy
        expect(FrontFile.new(filename: 'static/media/logo.39e717c5.png', format: 'png').possible?).to be_truthy
      end
    end

    context 'when front file is NOT entry point, favicon, manifest, css file or js file' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/js/2.2f5d7006.chunk.js', format: 'map')

        expect(front_file.possible?).to be_falsey
      end
    end

    context 'when front file is css map file or js map file' do
      context 'and source maps are allowed' do
        it 'returns truthy value' do
          expect(FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk.css', format: 'map', allow_source_maps: true).possible?).to be_truthy
          expect(FrontFile.new(filename: 'static/js/2.2f5d7006.chunk.js', format: 'map', allow_source_maps: true).possible?).to be_truthy
        end
      end

      context 'and source maps are NOT allowed' do
        it 'returns falsey value' do
          expect(FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk.css', format: 'map').possible?).to be_falsey
          expect(FrontFile.new(filename: 'static/js/2.2f5d7006.chunk.js', format: 'map').possible?).to be_falsey
        end
      end
    end
  end

  describe '#entry_point?' do
    context 'when path is "index.html"' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'index', format: 'html')

        expect(front_file.entry_point?).to be_truthy
      end
    end

    context 'when path is NOT "index.html"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'favicon', format: 'ico')

        expect(front_file.entry_point?).to be_falsey
      end
    end
  end

  describe '#favicon?' do
    context 'when path is "favicon.ico"' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'favicon', format: 'ico')

        expect(front_file.favicon?).to be_truthy
      end
    end

    context 'when path is NOT "favicon.ico"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'index', format: 'html')

        expect(front_file.favicon?).to be_falsey
      end
    end
  end

  describe '#manifest?' do
    context 'when path is "manifest.json"' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'manifest', format: 'json')

        expect(front_file.manifest?).to be_truthy
      end
    end

    context 'when path is NOT "manifest.json"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'index', format: 'html')

        expect(front_file.manifest?).to be_falsey
      end
    end
  end

  describe '#css_file?' do
    context 'when front file does NOT have possible filename' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/css/../../2.8d86fe7e.chunk.css', format: 'css')

        expect(front_file.css_file?).to be_falsey
      end
    end

    context 'when filename does NOT start with "static/css/"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '2.8d86fe7e.chunk.css', format: 'css')

        expect(front_file.css_file?).to be_falsey
      end
    end

    context 'when format is NOT "css"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk.css', format: 'js')

        expect(front_file.css_file?).to be_falsey
      end
    end

    context 'when front file has possible filename which starts with "static/css/" and format is "css"' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk.css', format: 'css')

        expect(front_file.css_file?).to be_truthy
      end
    end
  end

  describe '#js_file?' do
    context 'when front file does NOT have possible filename' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/js/../../2.2f5d7006.chunk.js', format: 'js')

        expect(front_file.js_file?).to be_falsey
      end
    end

    context 'when filename does NOT start with "static/js/"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '2.2f5d7006.chunk', format: 'js')

        expect(front_file.js_file?).to be_falsey
      end
    end

    context 'when format is NOT "js"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/js/2.2f5d7006.chunk', format: 'css')

        expect(front_file.js_file?).to be_falsey
      end
    end

    context 'when front file has possible filename which starts with "static/js/" and format is "js"' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'static/js/2.2f5d7006.chunk', format: 'js')

        expect(front_file.js_file?).to be_truthy
      end
    end
  end

  describe '#css_map_file?' do
    context 'when front file does NOT have possible filename' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/../../css/2.8d86fe7e.chunk.css', format: 'map')

        expect(front_file.css_map_file?).to be_falsey
      end
    end

    context 'when filename does NOT start with "static/css/"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '2.8d86fe7e.chunk.css', format: 'map')

        expect(front_file.css_map_file?).to be_falsey
      end
    end

    context 'when filename does NOT end with "css"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '2.8d86fe7e.chunk.js', format: 'map')

        expect(front_file.css_map_file?).to be_falsey
      end
    end

    context 'when format is NOT "map"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk.css', format: 'css')

        expect(front_file.css_map_file?).to be_falsey
      end
    end

    context 'when front file has possible filename which starts with "static/css/", ends with "css" and format is "map"' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'static/css/2.8d86fe7e.chunk.css', format: 'map')

        expect(front_file.css_map_file?).to be_truthy
      end
    end
  end

  describe '#js_map_file?' do
    context 'when front file does NOT have possible filename' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/js/../../2.2f5d7006.chunk.js', format: 'map')

        expect(front_file.js_map_file?).to be_falsey
      end
    end

    context 'when filename does NOT start with "static/js/"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '2.2f5d7006.chunk.js', format: 'map')

        expect(front_file.js_map_file?).to be_falsey
      end
    end

    context 'when filename does NOT end with "js"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '2.2f5d7006.chunk.css', format: 'map')

        expect(front_file.js_map_file?).to be_falsey
      end
    end

    context 'when format is NOT "map"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: '2.2f5d7006.chunk.js', format: 'js')

        expect(front_file.js_map_file?).to be_falsey
      end
    end

    context 'when front file has possible filename which starts with "static/js/", ends with "js" and format is "map"' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'static/js/2.2f5d7006.chunk.js', format: 'map')

        expect(front_file.js_map_file?).to be_truthy
      end
    end
  end

  describe '#png_file?' do
    context 'when front file does NOT have possible filename' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/media/../../logo.39e717c5', format: 'png')

        expect(front_file.png_file?).to be_falsey
      end
    end

    context 'when filename does NOT start with "static/media/"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'logo.39e717c5', format: 'png')

        expect(front_file.png_file?).to be_falsey
      end
    end

    context 'when format is NOT "png"' do
      it 'returns falsey value' do
        front_file = FrontFile.new(filename: 'static/media/logo.39e717c5', format: 'js')

        expect(front_file.png_file?).to be_falsey
      end
    end

    context 'when front file has possible filename which starts with "static/media/" and format is "png"' do
      it 'returns truthy value' do
        front_file = FrontFile.new(filename: 'static/media/logo.39e717c5', format: 'png')

        expect(front_file.png_file?).to be_truthy
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
end
