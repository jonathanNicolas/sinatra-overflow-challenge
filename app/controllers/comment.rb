get '/comments/new' do
  erb :comment
end

post '/comments/new' do
  @comment = Comment.create(user_id: session[:user_id], response_id: params[:response_id], response_type: params[:response_type], text: params[:text])
  if request.xhr?
    erb :"comment/_comment_ajax_response", :layout => false
  else
    redirect "/questions/#{params[:response_id]}"
  end
end

