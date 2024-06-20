class User < ApplicationRecord

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence:true, length: {minimum: 8}
  has_secure_password

  def self.authenticate_with_credentials email, password
    email = email.strip.downcase
    @user = User.find_by('lower(email) = ?', email)

    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end
end
