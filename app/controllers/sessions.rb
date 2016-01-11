get '/login' do
  session[:referrer] = request.referrer
  # client = Octokit::Client.new
  # github_login_url = client.authorize_url(CLIENT_ID, :scope => 'user:email')
  # redirect github_login_url
  redirect 'https://github.com/login/oauth/authorize?client_id=5a23d11f949dfe05b06e&scope=user:email'
end

get '/logout' do
  session[:referrer] = request.referrer
  session.delete(:access_token)
  session.delete(:username)
  redirect session[:referrer]
end

get '/callback' do
  session_code = request.env['rack.request.query_hash']['code']

  result = Octokit.exchange_code_for_token(session_code, CLIENT_ID, CLIENT_SECRET)
  access_token = result[:access_token]

  github_user_data = get_github_user_data(access_token)

  # if there's a user in the db with the currently logged in github username, show the registration form with the github info prefilled in the registration form
  # otherwise log in the github user by setting the session vars and redirect to their profile page
  user =  User.find_by_github_username(github_user_data.login)
  if user.nil?
    @github_username = github_user_data.login
    @github_name = github_user_data.name
    @github_email = github_user_data.private_emails.first
    @github_avatar_url = github_user_data.avatar_url
    erb :"user/new"
  else
    session[:access_token] = access_token
    session[:username] = github_user_data.login
    redirect session[:referrer]
  end
end