# -*- encoding : utf-8 -*-
class Author < ActiveRecord::Base
  has_many :book_author_relationships, foreign_key: "author_id", dependent: :destroy
  has_many :books, through: :book_author_relationships, source: :book

  validates_presence_of :name

  def own!(book)
    self.book_author_relationships.create!(book_id: book.id)
  end
end

