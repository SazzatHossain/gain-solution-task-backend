class V1::UsersController < V1::BaseController
  before_action :authenticate_user, only: [ :show,  :change_password, :update]
  require 'bcrypt'

  def index
    @users = User.all
  end

  def create
    @user = User.new(users_params)
    if User.where(phone_no: @user.phone_no).exists?
      result = {
        message: "Phone number already exists",
        status: "409"
      }
      render json: result, status: 409 and return
    elsif @user.save!
      render "create" && return
    else
      result = {
        message: "Registration Failed",
      }
    end
    render json: result

  end

  def update
    @user = User.find(@user.id)
    @user.update!(users_params.except(:password))
  end

  def destroy
    @user = User.find(params[:phone_no])
    @user.destroy

  end

  def show
    @user = User.find(@user.id)
  end

  ############## Change/Update Password ###############

#   def change_password
#     salt = BCrypt::Engine.generate_salt
#     user = User.find(@user.id)
#
#     if BCrypt::Password.new(user.password) == params[:old_password]
#       new_password = params[:new_password]
#       user.password = BCrypt::Engine.hash_secret(new_password, salt)
#       user.save!
#       render json: { success: true, message: "Password update successful" }
#     else
#       render json: { success: false, message: "Password update failed" }
#     end
#   end

  private

  def users_params
    hashed_password = BCrypt::Password.create(params[:password])
    params.required(:user).permit(:first_name, :last_name, :phone_no, :email, :password).merge(password: hashed_password)
  end

end
