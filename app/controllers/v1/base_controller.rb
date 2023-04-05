class V1::BaseController < ApplicationController
  def handle_generic_error error
    p error
    render json: {status: 500, message: 'Something Went Wrong'}
  end

  def authenticate_user
    authorization_object = Authorization.new(request)
    user_id = authorization_object.current_user
    unless user_id.nil?
      @user = User.find(user_id)
    end
    if @user.nil?
      render json: { status: 401,
                     message: 'Authorization Error'
      }, status: 401
    end

  end

  def disabled?(data)
    data.is_disabled == true
  end
end