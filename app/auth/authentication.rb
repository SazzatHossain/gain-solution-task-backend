class Authentication

  def initialize(user_object)
      @phone = user_object[:phone_no]
      @password = user_object[:password]
      @user = User.find_by_phone_no(@phone)
  end

  def authenticate
    true if @user && BCrypt::Password.new(@user.password) == @password
  end

  def verified
    true if @user
  end

  def generate_token()
      JsonWebToken.encode(user_id: @user.id)
  end

#   def get_user_type
#     @user.user_role_id
#   end

  def get_user_info
    @user
  end

  def get_first_name
    @user.first_name
  end

  def get_last_name
    @user.last_name
  end

  def get_user_id
    @user.id
  end

  def get_phone_no
    @user.phone_no
  end

  def get_user_full_name
    @info = @user.first_name + ' ' + @user.last_name
  end

end