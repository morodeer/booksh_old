# -*- encoding : utf-8 -*-

# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  real_name  :string(255)
#  wiki_link  :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class Author < ActiveRecord::Base
  has_many :book_author_relationships, foreign_key: "author_id", dependent: :destroy
  has_many :books, through: :book_author_relationships, source: :book, inverse_of: :authors

  has_attached_file :photo, styles: {medium: ['300x300', :jpg], thumb: ['80x80#', :jpg]},
                    url: "/system/author_photos/:hash.:extension", hash_secret: 'bookshsecret_author',
                    default_url: "/system/author_photos/:style/missing.jpg"
  validates_presence_of :name, length: {minimum: 1}


  #TODO: у каждого автора может быть несколько экземпляров каждый экземпляр на своем языке. Сделать указание языка





  def own!(book)
    self.book_author_relationships.create!(book_id: book.id)
    book.add_author(self)
  end


  def get_short_name
    names = name.split(' ')
    short_name = ''
    names[0..-2].each do |name|
      short_name += name[0].capitalize
      short_name += ". "
    end
    short_name += names[-1]
    short_name
  end

  def make_photo_from_url(photo_url)
      if photo_url
        self.photo = URI.parse(photo_url)
        self.save
      end
  end


  def photo_thumb_filename
    photo.url(:thumb)
  end

end

