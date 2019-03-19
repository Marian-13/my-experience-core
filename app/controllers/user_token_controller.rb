class UserTokenController < Knock::AuthTokenController
  skip_forgery_protection

  # POST '/user_token'
  def create
    render status: 200, json: { status: 'success', data: { token: auth_token.token } }
  end
end
