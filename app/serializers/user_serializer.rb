class UserSerializer < ActiveModel::Serializer
  include SessionsHelper
  attributes :id, :first_name, :last_name, :full_name, :avatar_thumb, :avatar_medium, :friend_status

  def full_name
    object.full_name
  end

  def avatar_thumb
    object.avatar.url(:thumb)
  end

  def avatar_medium
    object.avatar.url(:medium)
  end

  def friend_status
    unless current_user?(object)
      if current_user.is_friend_with?(object)
        'friend'
      elsif current_user.requested_friendship_with?(object)
        'friendship_requested'
      elsif current_user.has_pending_friendship_from?(object)
        'friendship_pending'
      else
        'no_friend'
      end
    end
  end
end
