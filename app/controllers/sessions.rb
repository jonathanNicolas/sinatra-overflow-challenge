get '/login' do
  client = Octokit::Client.new
  github_login_url = client.authorize_url(CLIENT_ID, :scope => 'user:email')
  redirect github_login_url
end

get '/logout' do
  session.delete(:access_token)
  session.delete(:username)
  session.delete(:user_id)
  redirect '/'
end

get '/callback' do
  session_code = request.env['rack.request.query_hash']['code']
  result = Octokit.exchange_code_for_token(session_code, CLIENT_ID, CLIENT_SECRET)
  access_token = result[:access_token]

  github_user_data = get_github_user_data(access_token)

  # if there's a user in the db with the currently logged in github username, return that user
  # otherwise show the registration form with the github info prefilled in the registration form
  user =  User.find_by_github_username(github_user_data.login)
  if user.nil?
    @github_username = github_user_data.login
    @github_fullname = github_user_data.name
    @github_email = github_user_data.private_emails.first
    @github_avatar_url = github_user_data.avatar_url
    erb :"user/new"
  else
    session[:access_token] = access_token
    session[:username] = github_user_data.login
    redirect "/users/#{github_user_data.login}"
  end
end

# get '/login' do
#   if session[:user_id]
#     @user = User.find(session[:user_id])
#     redirect "/users/#{@user.id}"
#   else
#     erb :login
#   end
# end

# post '/login' do
#   @user = User.find_by_email(params[:email])
#   if @user && @user.authenticate(params[:password_plaintext])
#     session[:user_id] = @user.id
#     redirect "/users/#{@user.id}"
#   else
#     session.delete(:user_id)
#     @error = "Please check your email address and password and try again."
#     erb :login
#   end
# end

# get '/logout' do
#   session.delete(:user_id)
#   redirect '/'
# end

