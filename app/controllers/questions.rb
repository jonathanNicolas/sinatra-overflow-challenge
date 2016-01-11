# route to show the index view
get '/questions' do
  @questions = Question.order('created_at DESC')
  @num_ans = {}
  @questions.each do |question|
    @num_ans[question.id] = question.answers.count
  end
  @names = {}
  @usernames = {}
  @questions.each do |question|
    user = User.find(question.user_id)
    @usernames[question.id] = user.github_username
    @names[question.id] = user.name
  end

  erb :'question/index'
end

# routes related to creating a new question
get '/questions/new' do
  if authenticated?
    erb :"question/new"
  else
    redirect '/login'
  end
end

post '/questions/new' do
  question_user = User.find_by_github_username(session[:username])
  question = Question.create(user_id: question_user.id, title: params[:title], text: params[:text])
  redirect "/questions/#{question.id}"
end

# routes related to posting a new answer
get '/questions/:question_id/answers/new' do
  if authenticated?
    @question = Question.find(params[:question_id])
    erb :"answer/new"
  else
    session[:error] = "You must be logged in to post an answer."
    redirect '/login'
  end
end

post '/questions/:question_id/answers/new' do
  answer_user = User.find_by_github_username(session[:username])
  @question = Question.find(params[:question_id])
  Answer.create(user_id: answer_user.id, question: @question, text: params[:text])
  redirect "/questions/#{params[:question_id]}"
end


# route to show an individual question page
get '/questions/:question_id' do
  @question = Question.find(params[:question_id])
  @question_user = @question.user
  @question_comments = @question.comments
  @question_answers = @question.answers
  erb :"question/show"
end

get '/questions/:question_id/:vote_type' do
  return unless authenticated?
  @question = Question.find(params[:question_id])
  vote_user = User.find_by_github_username(session[:username])
  if params[:vote_type] == "upvote"
    if @question.votes.create( user_id: vote_user.id, is_upvote: true, interaction_id: params[:question_id], interaction_type: "Question" )
      @question.vote_total += 1
      @question.save
    end
  elsif params[:vote_type] == "downvote"
    if @question.votes.create( user_id: vote_user.id, is_upvote: true, interaction_id: params[:question_id], interaction_type: "Question" )
      @question.vote_total -= 1
      @question.save
    end
  end
  if request.xhr?
    {votes: @question.vote_total, id: params[:question_id], type: "#{@question.class}"}.to_json
  else
  redirect "/questions/#{@question.id}"
  end
end

get '/questions/:question_id/answers/:answer_id/:vote_type' do
  return unless authenticated?
   @answer = Answer.find(params[:answer_id])
   vote_user = User.find_by_github_username(session[:username])
  if params[:vote_type] == "upvote"
    if @answer.votes.create( user_id: vote_user.id, is_upvote: true, interaction_id: params[:answer_id], interaction_type: "Answer" )
      @answer.vote_total += 1
      @answer.save
    end
  elsif params[:vote_type] == "downvote"
    if @answer.votes.create( user_id: vote_user.id, is_upvote: true, interaction_id: params[:answer_id], interaction_type: "Answer" )
      @answer.vote_total -= 1
      @answer.save
    end
  end
   if request.xhr?
    {votes: @answer.vote_total, id: params[:answer_id], type: "#{@answer.class}"}.to_json
  else
  redirect "/questions/#{params[:question_id]}"
  end
end
