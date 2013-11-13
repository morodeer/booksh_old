# -*- encoding : utf-8 -*-
module UsersHelper
  #include Devise::Controllers::Helpers

  def current_user? (user)
    user == current_user
  end
end
