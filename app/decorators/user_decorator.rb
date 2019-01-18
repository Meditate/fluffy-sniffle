class UserDecorator < Draper::Decorator
  delegate_all

  def can_comment?(commentable)
    commentable.comments.where(user: object).none?
  end

  delegate :name, to: :genre, prefix: true
end
