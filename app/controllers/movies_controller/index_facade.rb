class MoviesController::IndexFacade
  def movies
    Rails.cache.fetch(movies_scope.cache_key, expires_in: 1.hour) do
      fetch_movies
    end
  end

  private

  def connection
    @connection ||= Faraday.new(url: Rails.application.secrets.movies_api)
  end

  def url_for_movie(movie)
    format("%<title>s", title: ERB::Util.url_encode(movie.title))
  end

  def movies_scope
    @movies_scope ||= Movie.order(:title, :id)
  end

  def fetch_movies
    movies_scope.map do |movie|
      res = JSON.parse(connection.get(url_for_movie(movie)).body, symbolize_names: true)
      movie.attributes = {
        plot: res.dig(:data, :attributes, :plot),
        rating: res.dig(:data, :attributes, :rating),
        poster: res.dig(:data, :attributes, :poster)
      }
      movie.decorate
    end
  end
end
