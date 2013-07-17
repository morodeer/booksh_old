# -*- encoding : utf-8 -*-
class BookAuthorRelationship < ActiveRecord::Base
  belongs_to :author
  belongs_to :book

  validates_presence_of :author
  validates_presence_of :book
end
