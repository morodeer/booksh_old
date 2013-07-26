ThinkingSphinx::Index.define :user, with: :active_record do
  #fields
  indexes [first_name, last_name], :as => :name, sortable: true

  #indexes first_name, sortable: true


  #attributes
  has id, email, city, geo_coordinates, created_at, updated_at
  has friends.id, :as => :friend_ids

  set_property delta: true

end