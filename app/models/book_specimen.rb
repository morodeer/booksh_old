# -*- encoding : utf-8 -*-
class BookSpecimen < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
end
