require 'faker'

# create 20 dummy users
users = 20.times.map do
  User.create!( :first_name => Faker::Name.first_name,
                :last_name  => Faker::Name.last_name,
                :email      => Faker::Internet.email,
                :password   => BCrypt::Password.create("ham") )
end

# create 1 question for each user

  users.each do |user|
    user.questions.create!( :title => Faker::Lorem.sentence,
                            :text => Faker::Lorem.paragraphs(1)
      )
  end


# create answers
question_num = 1
users.each do |user|
  user.answers.create!( :text => Faker::Lorem.paragraphs(1),
                          :question_id => question_num
     )
  question_num += 1
end

question_num = 1
users.reverse!.each do |user|
  user.answers.create!( :text => Faker::Lorem.paragraphs(1),
                          :question_id => question_num
     )
  question_num += 1
end


# create COMMENTS
response_num = 1
users.each do |user|
  user.comments.create!( :text => Faker::Lorem.paragraphs(1),
                         :response_type => "Question",
                         :response_id => response_num
   )
  response_num += 1
end

response_num = 1
users.reverse!.each do |user|
  user.comments.create!( :text => Faker::Lorem.paragraphs(1),
                         :response_type => "Answer",
                         :response_id => response_num
   )
  response_num += 1
end

# create VOTES
interaction_num = 1
users.each do |user|
  user.votes.create!(
                      :interaction_type => "Question",
                      :interaction_id => interaction_num,
                      :is_upvote => true
   )
  question = Question.find(interaction_num)
  question.vote_total += 1
  question.save!
  interaction_num += 1
end

interaction_num = 1
users.reverse!.each do |user|
  user.votes.create!(
                      :interaction_type => "Answer",
                      :interaction_id => interaction_num,
                      :is_upvote => true
   )
  answer = Answer.find(interaction_num)
  answer.vote_total += 1
  answer.save!
  interaction_num += 1
end

interaction_num = 1
users.each do |user|
  user.votes.create!(
                      :interaction_type => "Comment",
                      :interaction_id => interaction_num,
                      :is_upvote => true
   )
  comment = Comment.find(interaction_num)
  comment.vote_total += 1
  comment.save!
  interaction_num += 1
end