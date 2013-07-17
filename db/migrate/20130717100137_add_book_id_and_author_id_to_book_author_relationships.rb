# -*- encoding : utf-8 -*-
class AddBookIdAndAuthorIdToBookAuthorRelationships < ActiveRecord::Migration
  def change
    add_column :book_author_relationships, :book_id, :integer
    add_column :book_author_relationships, :author_id, :integer
  end
end
