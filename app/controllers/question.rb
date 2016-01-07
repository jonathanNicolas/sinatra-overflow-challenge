get '/questions' do
  @questions = Question.all
  @num_ans = {}
  @questions.each do |question|
    @num_ans[question.id] = question.answers.count
  end
  # erb :'question/index'
  erb :index
end

get '/questions/:question_id' do
  @question = Question.find(params[:question_id])
  @question_user = @question.user
  @question_comments = @question.comments
  @question_answers = @question.answers
end