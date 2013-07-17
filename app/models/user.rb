class User < ActiveRecord::Base

  has_secure_password
  before_save :downcase_fields
  before_save :create_remember_token



  private
    def user_params
      params.require(:user).permit(:username,:email,:password,:password_confirmation)
    end

    def downcase_fields
      self.username.downcase
      self.email.downcase
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
