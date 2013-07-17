# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  has_many :reverse_book_author_relationships, foreign_key: "book_id", class_name: "BookAuthorRelationship", dependent: :destroy
  has_many :authors, through: :reverse_book_author_relationships, source: :author
  has_many :book_specimens

  validates :name, presence: true, length: {minimum: 2}
  validates :author_names, presence: true, length: {minimum: 2}

  before_save :generate_clean_isbn
  before_update :generate_clean_isbn


  private
    def generate_clean_isbn
      self.clean_isbn = self.isbn.gsub(/[^0-9XxХх]/,'')
    end

    def book_params
      params.require.permit!
    end
end
