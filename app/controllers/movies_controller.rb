class MoviesController < ApplicationController

  def initialize
    super
    @all_ratings = Movie.list_ratings
#    @ratings_ary = []
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/moviets/show.<extension> by default
  end

  def index
    #tu madre3
    @sort_by = params[:sort_by] @@ session[:sort_by]
#    @ratings = params[:ratings]
    @ratings_ary = @ratings ? @ratings.keys : @all_ratings
    @ratings = params[:ratings] || session[:ratings] || {}

    if params[:sort_by] != session[:sort_by]
      session[:sort_by] = sort
      redirect_to :sort_by => @sort_by, :ratings => @ratings and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort_by] = @sort
      session[:ratings] = @ratings
      redirect_to :sort_by => @sort_by, :ratings => @ratings and return
    end

#handleSessionLight
#@all_ratings=['G','PG','PG-13','R']
#@ratings_ary=['G','PG']
@movies = Movie.where(:rating => @ratings_ary).order(@sort_by) 
  end

  def handleSessionLight
    if params.has_key?(:ratings)
      session[:ratings] = params[:ratings]
    end
      session[:ratings] = params[:ratings]
  end

  def handleSession
    redirect = false
    if params.has_key?(:ratings)
      session[:ratings] = params[:ratings]
    elsif params[:commit] == "Refresh" || !(session.has_key? :ratings) 
        params[:ratings] = Movie.list_ratings
    else
      params[:ratings] = session[:ratings]
      redirect = true unless session[:ratings].nil?
    end
    
    if (params.has_key?(:sort_by))
      session[:sort_by] = params[:sort_by]
    else
      params[:sort_by] = session[:sort_by]
      redirect = true
    end
    
    if (redirect)
      redirect_to movies_path(params)
    end
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
