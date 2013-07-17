# -*- encoding : utf-8 -*-
class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :authors
      t.string :detail
      t.string :isbn
      t.string :clean_isbn
      t.string :publish_year

      t.timestamps
      t.index :clean_isbn
      t.index :name
    end
  end
end
