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

    #Genre per year. First need helper method to get all a genre's movies
    #then need to grab the year of each and count k:v = Year: number of movies

    def self.genre_movies(genre_name) #returns each movie instance associated with the genre given
        genre_id=  Genre.all.find_by(name: genre_name).id
        movies = GenresMovie.all.where(genre_id: genre_id)
        movies_arr = []
        movies.each do |movie|
            movie_id = movie.movie_id
            movie = Movie.find_by(id: movie_id)
           movies_arr << movie
        end 
        movies_arr
    end

    

end