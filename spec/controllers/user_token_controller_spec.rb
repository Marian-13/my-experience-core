require 'rails_helper'

RSpec.describe UserTokenController, type: :controller do
  describe '#create' do
    render_views

    context 'when user with +email+ not found' do
      it 'returns failure with code' do
        post :create, params: { auth: { email: '', password: 'secret' } }

        expect(response.body).to include_json(
          'status' => 'failure',
          'data' => {
            'code' => 1
          }
        )
      end
    end

    context 'when +password+ do not match' do
      it 'returns failure with code' do
        post :create, params: { auth: { email: 'user@example.com', password: '' } }

        expect(response.body).to include_json(
          'status' => 'failure',
          'data' => {
            'code' => 1
          }
        )
      end
    end

    context 'when +email+ and +password+ are valid' do
      it 'returns success with token' do
        user = create(:user, { email: 'user@example.com', password: 'secret' })

        post :create, params: { auth: { email: user.email, password: user.password } }

        expect(response.body).to include_json(
          'status' => 'success',
          'data' => {
            'token' => be
          }
        )
      end
    end
  end
end
