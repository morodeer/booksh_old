# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  remember_token  :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  city            :string(255)
#  geo_coordinates :string(255)
#

# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base

  has_many :book_specimens, foreign_key: 'owner_id'
  has_secure_password
  before_save :downcase_fields
  before_save :create_remember_token


  validates :first_name, presence: true, length: {maximum: 30}
  validates :last_name, presence: true, length: {maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 5}
  validates :password_confirmation, presence: true



  def obtain!(book)
    book_specimens.create!(book_id: book.id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private
    def user_params
      params.require(:user).permit(
          :username,:email,:password,:password_confirmation,
          :first_name,:last_name,:city,:geo_coordinates)
    end

    def downcase_fields
      self.username.downcase!
      self.email.downcase!
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
