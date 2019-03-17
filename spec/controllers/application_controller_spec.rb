require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#index', js: true do
    render_views

    context 'when user is logged in' do
      it 'renders `front` app with its relative bundle' do
        get :index

        expect(response.body).to match('<div data-react-class=\"front/App\"')
        expect(response.body).to match('<script src=\"/packs-test/js/front-')
      end
    end

    context 'when user is not logged in' do
      it 'renders `landing` app with its relative bundle' do
        get :index

        expect(response.body).to match('<div data-react-class=\"landing/App\"')
        expect(response.body).to match('<script src=\"/packs-test/js/landing-')
      end
    end
  end
end
