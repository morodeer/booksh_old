class AuthorSerializer < ActiveModel::Serializer
  #has_many :books
  attributes :id, :name, :real_name, :wiki_link

end
