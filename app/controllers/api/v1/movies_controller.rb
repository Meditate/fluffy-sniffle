class Api::V1::MoviesController < Api::V1::BaseController
  def index
    @movies = Movie.order(:title, :id)
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
