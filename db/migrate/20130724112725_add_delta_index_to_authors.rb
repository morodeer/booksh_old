class AddDeltaIndexToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :delta, :boolean, default: true, null: false
  end
end
