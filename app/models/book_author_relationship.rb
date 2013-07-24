# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: book_author_relationships
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  book_id    :integer
#  author_id  :integer
#

# -*- encoding : utf-8 -*-
class BookAuthorRelationship < ActiveRecord::Base
  belongs_to :author
  belongs_to :book

  validates_presence_of :author
  validates_presence_of :book
end
