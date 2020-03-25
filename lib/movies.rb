require_all 'lib'

class Movie < ActiveRecord::Base
    has_many :genre_movies
    has_many :genres, through: :genre_movies
    has_many :actor_movie
    has_many :actors, through: :actor_movie

    # validates :title,  :released, :runtime, :rating, :budget, :box_office, presence: true 

    def release_year
        self.released.year
    end

    def self.get_movie_genres(movie_name)
        movie_id = find_movie_id(movie_name)
        genres = GenresMovie.all.where(movie_id: movie_id)

    end
    
    def self.movies_by_year
        mby={} #movies by year hash
        Movie.all.each do |movie|
            if !(mby[movie.release_year])
                mby[movie.release_year]= {}
            end
        end 
        mby
    end

end

