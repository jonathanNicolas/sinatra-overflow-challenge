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

get '/questions/:question_id' do
  @question = Question.find(params[:question_id])
  @question_user = @question.user
  @question_comments = @question.comments
  @question_answers = @question.answers
end
