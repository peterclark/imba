class MoviesController < ActionController::API

  before_action :set_movie, only: [:show, :update, :destroy]

  def index
    render json: Movie.all
  end

  def create
    @movie = Movie.create movie_params
    render json: @movie
  end

  def update
    @movie.update movie_params
    render json: @movie
  end

  def destroy
    @movie.destroy
    render json: :ok
  end

  private

  def set_movie
    @movie = Movie.find params[:id]
  end

  def movie_params
    params.require(:movie).permit(:title, :year, :seen)
  end

end
