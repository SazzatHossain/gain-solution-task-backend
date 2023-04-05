json.status 200
json.message 'User Saved Successfully'
json.data do
  json.user do
    json.id @user.id
    json.first_name @user.first_name
    json.last_name @user.last_name
    json.phone_no @user.phone_no
    json.email @user.email
  end
end
