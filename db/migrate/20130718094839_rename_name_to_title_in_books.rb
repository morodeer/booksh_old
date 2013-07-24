# -*- encoding : utf-8 -*-
class RenameNameToTitleInBooks < ActiveRecord::Migration
  def change
    rename_column :books, :name, :title
  end
end
