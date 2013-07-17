# -*- encoding : utf-8 -*-
class ChangeAuthorsToAuthorNamesInBooks < ActiveRecord::Migration
  def change
    rename_column :books, :authors, :author_names
  end
end
