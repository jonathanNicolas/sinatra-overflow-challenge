get '/comments/new' do
  erb :comment
end

post '/comments/new/' do
  Comment.create(user_id: session[:user_id], response_id: params[:response_id], response_type: params[:response_type], text: params[:text])
end

