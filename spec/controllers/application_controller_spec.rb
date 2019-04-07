require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  render_views

  describe '#root' do
    it 'renders `front` SPA entry point' do
      get :root

      expect(response.body).to eq(IO.binread(FrontFile.entry_point.absolute_path))
    end

    it 'sets content_type to "text/html"' do
      get :root

      expect(response.content_type).to eq('text/html')
    end
  end

  describe '#public' do
    context 'when format is blank' do
      it 'renders `front` SPA entry point' do
        get :public, params: { filename: 'login' }

        expect(response.body).to eq(IO.binread(FrontFile.entry_point.absolute_path))
      end
    end

    context 'when format is "html"' do
      it 'renders `front` SPA entry point' do
        get :public, params: { filename: 'login', format: 'html' }

        expect(response.body).to eq(IO.binread(FrontFile.entry_point.absolute_path))
      end
    end

    context 'when requested `front` file is valid' do
      it 'renders that `front` file' do
        front_file = FrontFile.new(filename: 'favicon', format: 'ico')

        get :public, params: { filename: 'favicon', format: 'ico' }

        expect(response.body).to eq(IO.binread(front_file.absolute_path))
      end

      context 'and format is "css"' do
        it 'sets content_type to "text/css"' do
          get :public, params: { filename: 'static/css/2.8d86fe7e.chunk', format: 'css' }

          expect(response.content_type).to eq('text/css')
        end
      end

      context 'and format is "js"' do
        it 'sets content_type to "application/javascript"' do
          get :public, params: { filename: 'static/js/2.2f5d7006.chunk', format: 'js' }

          expect(response.content_type).to eq('application/javascript')
        end
      end

      context 'and format is "json"' do
        it 'sets content_type to "application/json"' do
          get :public, params: { filename: 'manifest', format: 'json' }

          expect(response.content_type).to eq('application/json')
        end
      end

      context 'and format is "ico"' do
        it 'sets content_type to "image/x-icon"' do
          get :public, params: { filename: 'favicon', format: 'ico' }

          expect(response.content_type).to eq('image/x-icon')
        end
      end

      context 'and format is "png"' do
        it 'sets content_type to "image/png"' do
          get :public, params: { filename: 'static/media/logo.39e717c5', format: 'png' }

          expect(response.content_type).to eq('image/png')
        end
      end

      context 'and source maps are allowed' do
        context 'and format is "map"' do
          it 'sets content_type to "application/json"' do
            # FrontFile.with_configs(allow_source_maps: true) do
              get :public, params: { filename: 'static/js/2.2f5d7006.chunk.js', format: 'map' }

              expect(response.content_type).to eq('application/json')
            # end
          end
        end
      end
    end

    context 'when requested `front` file is NOT valid' do
      it 'renders `front` SPA entry point' do
        get :public, params: { filename: 'main', format: 'css' }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
