ThinkingSphinx::Index.define :book, with: :active_record do
  #fields
  indexes title, sortable: true
  indexes detail
  indexes clean_isbn
  indexes authors.id, :as => :author_id

  #attributes
  has id, created_at, updated_at, author_names, isbn

  set_property delta: true

end