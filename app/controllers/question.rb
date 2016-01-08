# route to show the index view
get '/questions' do
  @questions = Question.all
  @num_ans = {}
  @questions.each do |question|
    @num_ans[question.id] = question.answers.count
  end
  @usernames = {}
  @user_ids = {}
  @questions.each do |question|
    user = User.find(question.user_id)
    @usernames[question.id] = user.full_name
    @user_ids[question.id] = user.id
  end

  erb :'question/index'
end

# routes related to creating a new question
get '/questions/new' do
  if session[:user_id]
    erb :"question/new"
  else
      @error = "You must login to post a question."
    erb :login
  end
end

post '/questions/new' do
  question = Question.create(user_id: session[:user_id], title: params[:title], text: params[:text])
  redirect "/questions/#{question.id}"
end

# routes related to posting a new answer
get '/questions/:question_id/answers/new' do
  if session[:user_id]
    @question = Question.find(params[:question_id])
    erb :"answer/new"
  else
    @error = "You must login to post an answer."
    erb :login
  end
end

post '/questions/:question_id/answers/new' do
  question = Question.find(params[:question_id])
  Answer.create(user_id: session[:user_id], question: question, text: params[:text])
  redirect "/questions/#{params[:question_id]}"
end


# route to show an individual question page
get '/questions/:question_id' do
  @question = Question.find(params[:question_id])
  @question_user = @question.user
  @question_comments = @question.comments
  @question_answers = @question.answers
  @question_vote_count = @question.votes.count
  "This will eventually be the individual question view."
end
