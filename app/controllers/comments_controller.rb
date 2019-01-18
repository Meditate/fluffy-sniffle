class CommentsController < ApplicationController
  def create
    facade = CreateFacade.new(params, current_user)
    if facade.save
      flash[:notice] = "comment posted successfuly"
    else
      flash[:alert] = "error on comment creating"
    end
    redirect_back(fallback_location: url_for(facade.commentable))
  end

  def destroy
    facade = DestroyFacade.new(params, current_user)
    if facade.delete
      flash[:notice] = "comment deleted successfuly"
    else
      flash[:alert] = "Error on comment deleting"
    end
    redirect_back(fallback_location: url_for(facade.commentable))
  end
end
