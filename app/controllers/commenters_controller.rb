class CommentersController < ApplicationController
  def index
    facade = IndexFacade.new

    @commenters = facade.commenters
  end
end
