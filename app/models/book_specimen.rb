# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: book_specimens
#
#  id            :integer          not null, primary key
#  book_id       :integer
#  owner_id      :integer
#  temp_owner_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

# -*- encoding : utf-8 -*-
class BookSpecimen < ActiveRecord::Base
  belongs_to :book
  belongs_to :user, foreign_key: 'owner_id'
  belongs_to :temp_user, class_name: "User", foreign_key: 'temp_owner_id'
end
