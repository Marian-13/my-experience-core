require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#index', js: true do
    render_views

    it 'renders `front` app with its relative bundle' do
      get :index

      expect(response.body).to match('<div data-react-class=\"App\"')
      expect(response.body).to match('<script src=\"/packs-test/js/front-')
    end
  end
end
