class CommentersController::IndexFacade
  def commenters
    Rails.cache.fetch(comments_scope.cache_key, expires_in: 1.hour) do
      @commenters ||=
        User
          .joins(:comments)
          .select("users.*, COUNT(comments.id) as comments_count")
          .where("comments.created_at > ?", Time.zone.now.beginning_of_day - 7.days)
          .group("users.id")
          .order("comments_count")
          .limit(10)
    end
  end

  private

  def comments_scope
    Comment.all
  end
end
