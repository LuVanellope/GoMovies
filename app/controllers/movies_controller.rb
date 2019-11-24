class MoviesController < ApplicationController

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: movie, status: :created
    else
      render json: { errors: movie.errors.messages }, status: 400
    end
  end

  def index
    movies = Movie.where('begin_date <= ? AND end_date >= ?', show_day, show_day)
    render json: movies, status: :ok
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :description, :url_image, :begin_date, :end_date)
  end

  def show_day
    params.require(:show_day)
  end
end
