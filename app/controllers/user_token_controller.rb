class UserTokenController < Knock::AuthTokenController
  skip_forgery_protection

  # POST '/api/user_token'
  def create
    render status: 200, json: { status: 'success', data: { token: auth_token.token } }
  end

  private

  def not_found
    render status: 400, json: { status: 'failure', data: { code: 1, message: 'Failed Authentication' } }
  end
end
