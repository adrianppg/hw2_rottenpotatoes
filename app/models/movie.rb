class Movie < ActiveRecord::Base
  def self.list_ratings
    ['G','PG','PG-13','R']
  end
end
