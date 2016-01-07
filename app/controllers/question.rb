get '/questions/:question_id' do
  @question = Question.find(params[:question_id])
  @question_user = @question.user

  @question_comments = @question.comments
  @question_comments_votes = {}
  # for comment vote counts, make a hash where key is comment id and value is num votes

  @question_answers = @question.answers
  # for answer vote counts, make a hash where key is answer id and value is num votes


end