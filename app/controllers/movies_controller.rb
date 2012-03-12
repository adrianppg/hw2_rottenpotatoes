class MoviesController < ApplicationController

  def initialize
    super
@all_ratings = Movie.list_ratings
  end
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort_by = params[:sort_by]
#    @all_ratings=Movie.list_ratings
    @all_ratings=['G','PG','PG-13','R']
#@ratings = params[:ratings]
    @rating_ary=['G','PG']
#@ratings_ary = @ratings ? @ratings.keys : @all_ratings
    @movies = Movie.order(@sort_by) 
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
