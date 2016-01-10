get '/comments/new' do
  erb :comment
end

post '/comments/new' do
  comment_user = User.find_by_github_username(session[:username])
  @comment = Comment.create(user_id: comment_user.id, response_id: params[:response_id], response_type: params[:response_type], text: params[:text])
  if request.xhr?
    erb :"comment/_comment_ajax_response", :layout => false
  else
    redirect "/questions/#{params[:response_id]}"
  end
end

