class Movie < ActiveRecord::Base
  def list_ratings
    return ['G','PG','PG-13','R']
  end
end
