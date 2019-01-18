class CommentsController::CreateFacade
  def initialize(params, user)
    self.params = params
    self.user = user.decorate
  end

  def save
    return unless can_comment?
    comment.save
  end

  def commentable
    @commentable ||=
      Object
        .const_get(secured_params[:commentable_type])
        .find(secured_params[:commentable_id])
  end

  def comment
    Comment.new(secured_params.merge(user_id: user.id))
  end

  attr_accessor :user, :params

  private

  def can_comment?
    user.can_comment?(commentable)
  end

  def secured_params
    @secured_params ||=
      params
        .require(:comment)
        .permit(
          :body,
          :commentable_type,
          :commentable_id
        )
  end
end
