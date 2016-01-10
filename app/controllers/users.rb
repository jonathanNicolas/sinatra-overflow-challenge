# get '/register' do
#   if session[:username]
#     @user = User.find(session[:username])
#     redirect "/users/#{@user.github_username}"
#   else
#     erb :register
#   end
# end

# post '/register' do
#   @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
#   @user.password = params[:password_plaintext]
#   if @user.save
#     redirect "/login"
#   else
#     @errors = @user.errors.full_messages
#     erb :register
#   end
# end

post '/users/new' do
  @user = User.new(github_username: params[:github_username], fullname: params[:fullname], email: params[:email], github_avatar_url: params[:github_avatar_url])
  if @user.save
    session[:username] = params[:github_username]
    redirect "/users/#{params[:github_username]}"
  else
    @errors = @user.errors.full_messages
    @github_username = params[:github_username]
    @github_fullname = params[:fullname]
    @github_email = params[:email]
    @github_avatar_url = params[:github_avatar_url]
    erb :"user/new"
  end
end

get '/users/:username' do
  @logged_in_as = User.find_by_github_username(session[:username]) if session[:username]
  @viewing_user = User.find_by_github_username(params[:username])
  @viewing_user_questions = @viewing_user.questions
  @viewing_user_answers = @viewing_user.answers
  @viewing_user_comments = @viewing_user.comments
  erb :"user/profile"
end