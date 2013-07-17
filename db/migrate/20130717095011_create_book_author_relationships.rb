# -*- encoding : utf-8 -*-
class CreateBookAuthorRelationships < ActiveRecord::Migration
  def change
    create_table :book_author_relationships do |t|


      t.timestamps
    end
  end
end
