# -*- encoding : utf-8 -*-
class BookSpecimen < ActiveRecord::Base
  belongs_to :book
  belongs_to :user, foreign_key: 'owner_id'
  belongs_to :temp_user, class_name: "User", foreign_key: 'temp_owner_id'
end
