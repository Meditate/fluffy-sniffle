class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    if movie.poster
      Rails.application.secrets.movies_poster_api +
        movie.poster
    else
      "http://lorempixel.com/100/150/" +
        %w[abstract nightlife transport].sample +
        "?a=" + SecureRandom.uuid
    end
  end
end
