
class AuthorOnlySerializer < ActiveModel::Serializer
  attributes :id, :name, :real_name, :wiki_link, :photo_thumb, :photo_medium

  def photo_thumb
    object.photo.url(:thumb)
  end

  def photo_medium
    object.photo.url(:medium)
  end


end

class BookSerializer < ActiveModel::Serializer
  has_many :authors, serializer: AuthorOnlySerializer
  attributes :id, :title, :isbn, :publish_year, :detail, :author_names, :cover_thumb

  def cover_thumb
    object.cover.url(:thumb)
  end


end
