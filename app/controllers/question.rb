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

# routes related to posting a comment to a question
get '/questions/:question_id/comments/new' do
end

post '/questions/:question_id/comments/new' do
end

# routes related to posting a comment to an answer
get '/questions/:question_id/answers/:answer_id/comments/new' do
end

post '/questions/:question_id/answers/:answer_id/comments/new' do
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
  @question = Question.find(params[:question_id])
  if params[:vote_type] == "upvote"
    if @question.votes.create( user_id: session[:user_id], is_upvote: true, interaction_id: params[:question_id], interaction_type: "Question" )
      @question.vote_total += 1
      @question.save
    end
  elsif params[:vote_type] == "downvote"
    if @question.votes.create( user_id: session[:user_id], is_upvote: true, interaction_id: params[:question_id], interaction_type: "Question" )
      @question.vote_total -= 1
      @question.save
    end
  end
  redirect "/questions/#{@question.id}"
end

get '/questions/:question_id/answers/:answer_id/:vote_type' do
   @answer = Answer.find(params[:answer_id])
  if params[:vote_type] == "upvote"
    if @answer.votes.create( user_id: session[:user_id], is_upvote: true, interaction_id: params[:answer_id], interaction_type: "Answer" )
      @answer.vote_total += 1
      @answer.save
    end
  elsif params[:vote_type] == "downvote"
    if @answer.votes.create( user_id: session[:user_id], is_upvote: true, interaction_id: params[:answer_id], interaction_type: "Answer" )
      @answer.vote_total -= 1
      @answer.save
    end
  end
  redirect "/questions/#{params[:question_id]}"
end
