# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base

  has_many :reverse_book_author_relationships, foreign_key: "book_id", class_name: "BookAuthorRelationship", dependent: :destroy
  has_many :authors, through: :reverse_book_author_relationships, source: :author, inverse_of: :books
  has_many :authors, through: :reverse_book_author_relationships, source: :author, inverse_of: :books
  accepts_nested_attributes_for :authors, allow_destroy: true
  has_many :book_specimens



  validates :tit, presence: true, length: {minimum: 2}
  #validates :author_names, presence: true, length: {minimum: 2}

  before_save :generate_clean_isbn
  before_update :generate_clean_isbn

  def add_author(author)
      if author_names
      temp_authors = self.author_names.split(/,/)
      else
      temp_authors = []
      end
      temp_authors.push(author.get_short_name)
      set_authors_from_array(temp_authors)
  end


  def set_authors_from_array(array)
    self.author_names = array.join(', ')
    save
  end



  def get_authors
    authors
  end

  private
    def generate_clean_isbn
      if isbn
        self.clean_isbn = self.isbn.gsub(/[^0-9XxХх]/,'')
      end
    end

    def book_params
      params.require.permit!
    end

end
