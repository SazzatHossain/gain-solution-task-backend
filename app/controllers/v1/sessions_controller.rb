class V1::SessionsController < V1::BaseController
  # before_action :authenticate_user, only: [:verify_otp]
  def sign_in
    auth_object = Authentication.new(signin_params)
    if auth_object.authenticate
      if auth_object.verified
        #   respond_to do |format|
        result = {
            status: 200,
            message: "Login Successful",
            token: auth_object.generate_token,
#             user_type: auth_object.get_user_type,
            user_obj: auth_object.get_user_info,
            user_id: auth_object.get_user_id,
            first_name: auth_object.get_first_name,
            last_name: auth_object.get_last_name
        }
        user = User.find(result[:user_id])
        user.token = result[:token]
#         user.logged_in_at = DateTime.now
        user.save
        render json: result
        # format.any { render json: result }
        # end
      else
        render json: {success: false,
                      status: 403,
                      mobile_no: auth_object.get_phone_no,
                      message: "Mobile Number / Email not verified"
        }, status: 403
      end
    else
      render json: {status: :unauthorized, # 401 is http code for unauthorized request,
                    success: false,
                    message: "Incorrect username/password combination"}, status: :unauthorized
    end
  end


  private

  def signin_params
    params.permit(:phone_no, :password)
  end

end
