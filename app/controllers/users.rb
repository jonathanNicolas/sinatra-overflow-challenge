get '/users/:user_id' do
  @logged_in_as = User.find(session[:user_id]) if session[:user_id]
  @viewing_user = User.find(params[:user_id])
  @viewing_user_questions = @viewing_user.questions

  erb :user
end