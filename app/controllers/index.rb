get '/' do
  redirect '/questions'
end

get '/secret' do
  redirect '/login' unless session[:user_id]
  "Secret area!"
end