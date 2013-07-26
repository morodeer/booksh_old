ThinkingSphinx::Index.define :book, with: :active_record do
  #fields
  indexes title, sortable: true
  indexes detail
  indexes clean_isbn
  indexes authors.id, :as => :author_id
  indexes authors.name, :as => :author_name





  #attributes
  has id, created_at, updated_at, author_names, isbn
  has owners.id, :as => :owner_ids

  set_property delta: true

end