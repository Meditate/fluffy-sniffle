class CommentsController::DestroyFacade
  def initialize(params, user)
    self.params = params
    self.user = user
  end

  def delete
    comment.destroy
  end

  def commentable
    @commentable ||=
      Object
        .const_get(secured_params[:commentable_type])
        .find(secured_params[:commentable_id])
  end

  def comment
    user.comments.find(secured_params[:id])
  end

  attr_accessor :user, :params

  private

  def secured_params
    @secured_params ||=
      params
        .permit(
          :id,
          :commentable_type,
          :commentable_id
        )
  end
end
