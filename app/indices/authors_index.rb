ThinkingSphinx::Index.define :author, with: :active_record do
  #fields
  indexes name, sortable: true

  #attributes
  has id, created_at, updated_at, real_name, wiki_link

  set_property delta: true

end