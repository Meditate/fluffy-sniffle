class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    facade = IndexFacade.new

    respond_to do |format|
      format.js do
        @movies = facade.movies
      end
      format.html
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def send_info
    respond_to do |format|
      format.js do
        @movie = Movie.find(params[:id])
        MovieInfoMailer.delay.send_info(current_user, @movie)
        flash.now[:notice] = "Email sent with movie info"
        render layout: false
      end
    end
  end

  def export
    respond_to do |format|
      format.js do
        file_path = "tmp/movies.csv"
        MovieExporter.new.delay.call(current_user, file_path)
        flash.now[:notice] = "Email sent with movie info"
        render layout: false
      end
    end
  end
end
