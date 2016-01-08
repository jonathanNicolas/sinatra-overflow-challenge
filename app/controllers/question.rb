# route to show the index view
get '/questions' do
  @questions = Question.all
  @num_ans = {}
  @questions.each do |question|
    @num_ans[question.id] = question.answers.count
  end
  @usernames = {}
  @questions.each do |question|
    @usernames[question.id] = User.find(question.user_id).full_name
  end

  erb :'question/index'
end

# routes related to creating a new question
get '/questions/new' do
  if session[:user_id]
    "You are logged in. Eventually you'll see the form to make post a new question."
  else
    "You must log in before you can post a new question."
  end
end

post '/questions/new' do
  question = Question.create(user_id: session[:user_id], title: params[:title], text: params[:text])
  redirect "/questions/#{question.id}"
end

# routes related to posting a new answer
get '/questions/:question_id/answers/new' do
  if session[:user_id]
    "You are logged in. Eventually you'll see the form to post a new answer."
  else
    "You must log in before you can post a new answer."
  end
end

post '/questions/:question_id/answers/new' do
  Answer.create(user_id: session[:user_id], question: params[:question_id], text: params[:text])
  redirect "/questions/#{params[:question_id]}"''
end


# route to show an individual question page
get '/questions/:question_id' do
  @question = Question.find(params[:question_id])
  @question_user = @question.user
  @question_comments = @question.comments
  @question_answers = @question.answers
end
