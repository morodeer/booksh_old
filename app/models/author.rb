# -*- encoding : utf-8 -*-
class Author < ActiveRecord::Base
  has_many :book_author_relationships, foreign_key: "author_id", dependent: :destroy
  has_many :books, through: :book_author_relationships, source: :book, inverse_of: :authors

  validates_presence_of :name

  def own!(book)
    self.book_author_relationships.create!(book_id: book.id)
    book.add_author(self)
  end


  def get_short_name
    names = name.split(' ')
    shname = ''
    names[0..-2].each do |name|
      shname += name[0].capitalize
      shname += ". "
    end
    shname += names[-1]
    shname
  end
end

