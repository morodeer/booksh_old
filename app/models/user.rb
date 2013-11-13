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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :book_specimens, foreign_key: 'owner_id'
  has_many :books, through: :book_specimens, source: :book, inverse_of: :owners
  has_many :friendships
  has_many :friends, through: :friendships
  has_attached_file :avatar, styles: {medium: ['300x300', :jpg], thumb: ['80x80#', :jpg]},
                    url: "/system/avatars/:hash.:extension", hash_secret: 'bookshsecret',
                    default_url: "/system/avatars/:style/missing.jpg"
  before_save :downcase_fields
  before_save :create_remember_token


  validates :first_name, presence: true, length: {maximum: 30}
  validates :last_name, presence: true, length: {maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}



  def obtain!(book)
    book_specimens.create!(book_id: book.id)
  end

  def request_friendship_with(friend)
    unless self == friend or
        self.is_friend_with?(friend) or
        self.requested_friendship_with?(friend) or
        self.has_pending_friendship_from?(friend)
      friendships.create!(friend_id: friend.id, status: 'requested')
      friend.friendships.create!(friend_id: self.id, status: 'pending')
    end
  end

  def accept_friendship_from(friend)
    if self.has_pending_friendship_from?(friend)
      Friendship.
          find_by_user_id_and_friend_id(self,friend).
            update_attributes(status: 'accepted')
      Friendship.
          find_by_user_id_and_friend_id(friend,self).
            update_attributes(status: 'accepted')
    end
  end

  def decline_friendship_from(friend)
    unless current_user?(friend)

    if self.has_pending_friendship_from?(friend)
      Friendship.
          find_by_user_id_and_friend_id(self,friend).
          destroy
      Friendship.
          find_by_user_id_and_friend_id(friend,self).
          destroy
    end
    end

  end

  def recall_friendship_request_with(friend)
    if self.requested_friendship_with?(friend)
      Friendship.
          find_by_user_id_and_friend_id(self,friend).
          destroy
      Friendship.
          find_by_user_id_and_friend_id(friend,self).
          destroy
    end
  end

  def unfriend(friend)
    if self.is_friend_with?(friend)
      Friendship.find_by_user_id_and_friend_id(self, friend).destroy
      Friendship.find_by_user_id_and_friend_id(friend, self).destroy
    end
  end

  def is_friend_with?(user)
    Friendship.exists?(user_id: user.id, friend_id: self.id, status: 'accepted')
  end

  def requested_friendship_with?(friend)
    Friendship.exists?(user_id: self.id, friend_id: friend.id, status: 'requested')
  end

  def has_pending_friendship_from?(friend)
    Friendship.exists?(user_id: self.id, friend_id: friend.id, status: 'pending')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_thumb_filename
		avatar.url(:thumb)
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
