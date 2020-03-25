class Genre < ActiveRecord::Base
    has_many :genre_movies
    has_many :movies, through: :genre_movies

    validates :name, presence: true 

    def self.get_genres_actors(genre_name)
        actor_array = []
       genre_id=  Genre.all.find_by(name: genre_name).id
        movies = GenresMovie.all.where(genre_id: genre_id)
        movies.each do |movie|
            movie_id = movie.movie_id
            actors = ActorMovie.all.where(movie_id: movie_id)
            actors.map do |actor|
                actor_list = Actor.all.find_by(id: actor.actor_id).name
                actor_array << actor_list
            end
        end
     actor_array
    end



end