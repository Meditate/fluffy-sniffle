class Api::V1::MoviesController < Api::BaseController
  def index
    @movies = Movie.order(:title, :id).decorate
  end

  def show
    @movie = Movie.find(params[:id]).decorate
  end
end
