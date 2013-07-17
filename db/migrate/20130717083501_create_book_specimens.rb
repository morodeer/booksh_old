# -*- encoding : utf-8 -*-
class CreateBookSpecimens < ActiveRecord::Migration
  def change
    create_table :book_specimen do |t|
      t.integer :book_id
      t.integer :owner_id
      t.integer :temp_owner_id

      t.timestamps
    end
  end
end
