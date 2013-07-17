class BookSpecimensController < ApplicationController

  def new
    @specimen = BookSpecimen.new
  end

end
