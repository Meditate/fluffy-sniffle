class Api::V2::MoviesController < Api::BaseController
  def index
    @movies = Movie.order(:title, :id).includes(:genre).decorate
  end

  def show
    @movie = Movie.find(params[:id]).decorate
  end
end
