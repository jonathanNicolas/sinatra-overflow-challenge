class User < ActiveRecord::Base

  has_many :questions
  has_many :comments
  has_many :votes
  has_many :answers

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(password_plaintext)
    @password = BCrypt::Password.create(password_plaintext)
    self.password_hash = @password
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def authenticate(password)
    return self.password == password
  end
end
