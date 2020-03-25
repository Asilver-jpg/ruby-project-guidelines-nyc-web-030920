class Movie < ActiveRecord::Base
    has_many :genre_movies
    has_many :genres, through: :genre_movies
    has_many :actor_movie
    has_many :actors, through: :actor_movie

    # validates :title,  :released, :runtime, :rating, :budget, :box_office, presence: true 

    def release_year
        self.release.year
    end

    #validates :title,  :released, :runtime, :rating, :budget, :box_office, presence: true 

end

