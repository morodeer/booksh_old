# -*- encoding : utf-8 -*-
class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :real_name
      t.string :wiki_link

      t.timestamps
      t.index :name
      t.index :real_name
    end
  end
end
