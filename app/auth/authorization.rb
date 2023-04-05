class Authorization
  def initialize(request)
    @token = request.params['token'] || request.cookies['token']
  end

  def current_user
    JsonWebToken.decode(@token)[:user_id] if @token
  end
end